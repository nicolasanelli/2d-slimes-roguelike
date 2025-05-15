class_name Sword
extends BaseWeapon

# Removing the slash effect preloads since we're no longer using them
# var _slash_effect = preload("res://components/weapons/sword/slash/slash.tscn")
# var _special_slash_effect = preload("res://components/weapons/sword/slash_special/slash_special.tscn")

@onready var _area: Area2D = %Area2D
@onready var _timer: CTimer = $CTimer
@onready var _weapon_pivot: Marker2D = %WeaponPivot
@onready var _sword_hitbox: Area2D = %SwordHitbox

@export var _disabled: bool = false


const ROTATION_SPEED = 25
var _angle = 0
var _is_attacking = false
var _slash_tween: Tween
var _hit_enemies = []

const SLASH_DURATION = 0.25 # Seconds

#region Engine
func _ready() -> void:
	_configure_timer()
	
	_sword_hitbox.body_entered.connect(_on_sword_body_entered)
	_sword_hitbox.monitoring = false

func _process(delta: float) -> void:
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
	if is_node_ready():
		_configure_timer()

func get_resource() -> SwordResource:
	return super.get_resource()
#endregion

func _on_sword_body_entered(body: Node2D) -> void:
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
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", 0, 0.01)
	_slash_tween.tween_callback(func():
		if is_instance_valid(_sword_hitbox):
			_sword_hitbox.monitoring = true
	)
	
	# First half of slash - go to left side relative to current aim
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", -get_resource().slash_angle, SLASH_DURATION / 3)
	_slash_tween.tween_callback(func():
		AudioManager.play_swing()
	)
	
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", get_resource().slash_angle, SLASH_DURATION * 2 / 3)
	_slash_tween.tween_property(_weapon_pivot, "rotation_degrees", 0, SLASH_DURATION / 3)
	# Disable hitbox and reset attack state when animation completes
	_slash_tween.tween_callback(func():
		if is_instance_valid(_sword_hitbox):
			_sword_hitbox.monitoring = false
		_is_attacking = false
	)
