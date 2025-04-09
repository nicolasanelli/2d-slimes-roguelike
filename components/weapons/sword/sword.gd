class_name Sword
extends BaseWeapon

# Removing the slash effect preloads since we're no longer using them
# var _slash_effect = preload("res://components/weapons/sword/slash/slash.tscn")
# var _special_slash_effect = preload("res://components/weapons/sword/slash_special/slash_special.tscn")

@onready var _area: Area2D = %Area2D
@onready var _sword_sprite: Sprite2D = %Sword
@onready var _attack_point: Marker2D = %AttackPoint
@onready var _timer: CTimer = $CTimer
@onready var _weapon_pivot: Marker2D = %WeaponPivot
@onready var _sword_hitbox: Area2D = %SwordHitbox
@onready var _sword_hitbox_collision: CollisionShape2D = %CollisionShape2D

@export var _disabled: bool = false
@export var _swing_steps: int = 15 # Number of steps for hit detection during swing


const ROTATION_SPEED = 25
var _angle = 0
var _is_attacking = false
var _slash_tween: Tween
var _hit_enemies = []

# Slash animation parameters
const SLASH_DURATION = 0.25 # Seconds
const BASE_HITBOX_SIZE = Vector2(70.0, 30.0) # Base capsule size (height, radius*2)
const HITBOX_SIZE_SCALE_FACTOR = 1.2 # How much to scale the hitbox per rarity level

var _current_slash_angle = 60.0 # Will be updated from resource

#region Engine
func _ready() -> void:
	# Add additional safety checks to prevent crashes on startup
	if not _sword_hitbox_collision:
		push_error("SwordHitboxCollision not found! Check scene structure.")
		
	_configure_timer()
	
	# Connect the sword hitbox to detect hits
	if _sword_hitbox:
		_sword_hitbox.body_entered.connect(_on_sword_body_entered)
	
	# Disable hitbox initially
	if _sword_hitbox:
		_sword_hitbox.monitoring = false
	

func _process(delta: float) -> void:
	var abs_rot = abs(int(rotation_degrees) % 360)
	if (abs_rot >= 90 and abs_rot <= 270):
		_sword_sprite.flip_v = true
		_attack_point.position.y = 11.0
	else:
		_sword_sprite.flip_v = false
		_attack_point.position.y = -11.0
	
	# Only rotate the sword with the player aim if not currently slashing
	if not _is_attacking:
		rotate(_angle * delta * ROTATION_SPEED * GlobalTimer.get_factor())

func _physics_process(_delta: float) -> void:
	if (Util.auto_aim()):
		var enemies_in_range: Array[Node2D] = _area.get_overlapping_bodies()
		if enemies_in_range.size() > 0:
			var target = enemies_in_range.front()
			_angle = get_angle_to(target.global_position)
		else:
			_angle = 0
	else:
		var target = get_global_mouse_position()
		_angle = get_angle_to(target)
#endregion

#region Timer
func _configure_timer() -> void:
	if _disabled: return
	if not _timer: return
	
	_timer.wait_time = (1 / get_resource().attack_speed)
	
	if _timer.is_stopped():
		_timer.start()
		_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	attack()
#endregion

#region Override
func setup() -> void:
		_configure_timer()
		_update_hitbox_size()

func get_resource() -> SwordResource:
	return super.get_resource()
#endregion


func _update_hitbox_size() -> void:
	if not get_resource() or not _sword_hitbox_collision:
		return
		
	# Get the capsule shape
	var capsule_shape = _sword_hitbox_collision.shape as CapsuleShape2D
	if not capsule_shape:
		return
		
	# Scale the hitbox based on rarity level
	var scale_multiplier = 1.0 + (get_resource().rarity * 0.15)
	
	# Update the capsule dimensions
	capsule_shape.height = BASE_HITBOX_SIZE.x * scale_multiplier
	capsule_shape.radius = BASE_HITBOX_SIZE.y * scale_multiplier / 2
	
	# Use slash angle from resource and apply rarity scaling
	_current_slash_angle = get_resource().slash_angle * (1.0 + (get_resource().rarity * 0.1))
	

# Safely create a StyleBoxFlat for debug visuals
func _create_debug_stylebox(color: Color) -> StyleBoxFlat:
	# Use direct instantiation instead of .new()
	var style = StyleBoxFlat.new()
	style.bg_color = Color(color.r, color.g, color.b, 0.25) # Semitransparent
	style.border_color = Color(color.r, color.g, color.b, 0.5) # More opaque border
	style.border_width_left = 1
	style.border_width_top = 1
	style.border_width_right = 1
	style.border_width_bottom = 1
	style.corner_radius_top_left = 15
	style.corner_radius_top_right = 15
	style.corner_radius_bottom_right = 15
	style.corner_radius_bottom_left = 15
	return style

# Check for enemies in the current swing position
func _check_for_hits_at_angle(angle_deg: float) -> void:
	if not is_instance_valid(_weapon_pivot) or not is_instance_valid(_sword_hitbox):
		return
		
	# Save current rotation
	var original_rotation = _weapon_pivot.rotation_degrees
	
	# Temporarily rotate the sword to the check position
	_weapon_pivot.rotation_degrees = angle_deg
	
	# Get all potential enemies in the detection area
	var bodies = _sword_hitbox.get_overlapping_bodies()
	for body in bodies:
		if body in _hit_enemies:
			continue
			
		if body.has_method("take_damage"):
			if get_resource().is_special:
				# Special attack deals double damage and has knockback effect
				body.take_damage(get_resource().damage * 2)
				
				# Apply knockback if the body has a knockback method
				if body.has_method("apply_knockback"):
					var direction = (body.global_position - global_position).normalized()
					body.apply_knockback(direction * 300)
			else:
				body.take_damage(get_resource().damage)
				
			# Add to hit enemies list to prevent multiple hits in one slash
			_hit_enemies.append(body)
	
	# Restore original rotation
	_weapon_pivot.rotation_degrees = original_rotation

func _on_sword_body_entered(body: Node2D) -> void:
	# We'll handle hit detection manually during the swing
	pass

func attack() -> void:
	if _is_attacking:
		return
	
	_is_attacking = true
	_hit_enemies.clear()
	
	# Cancel any existing slash animation
	if _slash_tween and _slash_tween.is_valid():
		_slash_tween.kill()
	
	# Create slash tween animation
	_slash_tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
	# Begin with weapon pivot at 0 (aligned with the sword's current aim)
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", 0, 0.01)
	
	# Enable sword hitbox for visualization
	_slash_tween.tween_callback(func():
		if is_instance_valid(_sword_hitbox):
			_sword_hitbox.monitoring = true
	)
	
	# First half of slash - go to left side relative to current aim
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", -_current_slash_angle, SLASH_DURATION / 3)
	
	# Play sound halfway through the first half
	_slash_tween.tween_callback(func():
		AudioManager.play_swing()
		
		# Check for hits at the start position
		_check_for_hits_at_angle(-_current_slash_angle)
	)
	
	# Set up intermediate hit checks along the swing arc
	var num_steps = _swing_steps
	var step_angle = (2 * _current_slash_angle) / float(num_steps)
	
	for i in range(1, num_steps):
		var angle_deg = - _current_slash_angle + (i * step_angle)
		
		# Add a tiny delay to spread checks through the swing
		var progress = float(i) / float(num_steps)
		var delay = (SLASH_DURATION * 2 / 3) * progress
		
		_slash_tween.tween_callback(func():
			_check_for_hits_at_angle(angle_deg)
		).set_delay(delay * 0.05) # Reduced delay for more responsive hit detection
	
	# Full swing to right side relative to current aim
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", _current_slash_angle, SLASH_DURATION * 2 / 3)
	
	# Check for hits at the end position but don't create a slash effect
	_slash_tween.tween_callback(func():
		_check_for_hits_at_angle(_current_slash_angle)
	)
	
	# Return to center (aligned with aim)
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", 0, SLASH_DURATION / 3)
	
	# Disable hitbox and reset attack state when animation completes
	_slash_tween.tween_callback(func():
		if is_instance_valid(_sword_hitbox):
			_sword_hitbox.monitoring = false
		_is_attacking = false
	)
