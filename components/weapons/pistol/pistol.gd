class_name Pistol 
extends Node2D


var _bullet_component = preload("res://components/weapons/pistol/bullet/bullet.tscn")
var _bullet_special_component = preload("res://components/weapons/pistol/bullet_special/bullet_special.tscn")


@onready var _area: Area2D = %Area2D
@onready var _pistol_sprite: Sprite2D = %Pistol
@onready var _shooting_point: Marker2D = %ShootingPoint
@onready var _timer: CTimer = $CTimer

@export var _disabled: bool = false


var _current_resource: PistolResource:
	set(value):
		_current_resource = value
		_configure_timer()

const ROTATION_SPEED = 25
var _angle = 0

#region Engine
func _ready() -> void:
	_configure_timer()

func _process(delta: float) -> void:
	var abs_rot = abs(int(rotation_degrees) % 360)
	if (abs_rot >= 90 and abs_rot <= 270): 
		_pistol_sprite.flip_v = true
		_shooting_point.position.y = 11.0
	else:
		_pistol_sprite.flip_v = false
		_shooting_point.position.y = -11.0
	
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
	
	_timer.wait_time = (1 / _current_resource.attack_speed)
	
	if _timer.is_stopped(): 
		_timer.start()
		_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	shoot()
#endregion


func upgrade(resource: BaseWeaponResource) -> void:
	_current_resource = resource

func shoot() -> void:
	for n in range(_current_resource.bullets):
		if Debugger.instance:
			Debugger.instance.increaseBulletsShooted()
		
		var bullet
		if _current_resource.is_special:
			bullet = _bullet_special_component.instantiate()
		else:
			bullet = _bullet_component.instantiate()
		
		bullet.global_position = _shooting_point.global_position
		bullet.global_rotation = _shooting_point.global_rotation
		
		bullet.set_damage(_current_resource.damage)
		
		_shooting_point.add_child(bullet)
		await get_tree().create_timer(0.03).timeout
