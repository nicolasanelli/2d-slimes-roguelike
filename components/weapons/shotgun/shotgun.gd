class_name Shotgun 
extends BaseWeapon

const _bullet_component = preload("res://components/weapons/shotgun/shotgun_bullet/shotgun_bullet.tscn")

@onready var _area: Area2D = %Area2D
@onready var _pistol_sprite: Sprite2D = %Shotgun
@onready var _shooting_point: Marker2D = %ShootingPoint
@onready var _timer: CTimer = $CTimer
@export var _disabled: bool = false

const ROTATION_SPEED = 25
var _angle = 0

#region Engine
func _ready() -> void:
	_configure_timer()

func _process(delta: float) -> void:
	var abs_rot = abs(int(rotation_degrees) % 360)
	if (abs_rot >= 90 and abs_rot <= 270): 
		_pistol_sprite.flip_v = true
		_shooting_point.position.y = 18.0
	else:
		_pistol_sprite.flip_v = false
		_shooting_point.position.y = -18.0
	
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
	shoot()
#endregion

#region Override
func get_resource() -> ShotgunData:
	return super.get_resource()
#endregion

func shoot() -> void:
	var bullets: Array = []
	
	for n in range(get_resource().bullets):
		Statistics.add_bullet_shooted()
		
		var bullet = (_bullet_component.instantiate() as ShotgunBullet)
		bullet.global_position = _shooting_point.global_position
		bullet.set_damage(get_resource().damage)
		bullet.set_max_range(get_resource().distance)
		if get_resource().is_special:
			bullet.set_as_special()
		
		bullets.push_back(bullet)
	
	for n in range(get_resource().positions.size()):
		var degree = get_resource().positions[n]
		bullets[n].global_rotation = _shooting_point.global_rotation + deg_to_rad(degree)
	
	for n in bullets:
		_shooting_point.add_child(n)
		
	AudioManager.play_shotgun()
