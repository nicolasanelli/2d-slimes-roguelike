class_name Pistol 
extends Node2D


var _bullet_component = preload("res://components/weapons/bullet/bullet.tscn")
var _bullet_special_component = preload("res://components/weapons/bullet_special/bullet_special.tscn")


@onready var _area: Area2D = %Area2D
@onready var _pistol_sprite: Sprite2D = %Pistol
@onready var _shooting_point: Marker2D = %ShootingPoint
@onready var _timer: Timer = $Timer

@export var _disabled: bool = false

var _current_resource_index: int = 0:
	set(value):
		_current_resource_index = value
		_configure_current_resource()
		_configure_timer()
var _current_resource: PistolResource
var _resources: Array[PistolResource] = [
	load("res://data/weapons/pistol/001_common_pistol.tres"),
	load("res://data/weapons/pistol/002_uncommon_pistol.tres"),
	load("res://data/weapons/pistol/003_rare_pistol.tres"),
	load("res://data/weapons/pistol/004_epic_pistol.tres"),
	load("res://data/weapons/pistol/005_legendary_pistol.tres"),
	load("res://data/weapons/pistol/006_mythic_pistol.tres"),
]


#region Engine
func _ready() -> void:
	_configure_current_resource()
	_configure_timer()
	
func _process(_delta: float) -> void:
	var rot = rotation_degrees
	if (rot >= -270 and rot <= -90) or (rot >= 90 and rot <= 270): 
		_pistol_sprite.flip_v = true
		_shooting_point.position.y = 11.0
	else:
		_pistol_sprite.flip_v = false
		_shooting_point.position.y = -11.0

func _physics_process(_delta: float) -> void:
	var enemies_in_range: Array[Node2D] = _area.get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target = enemies_in_range.front()
		look_at(target.global_position)
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

func _configure_current_resource() -> void:
	_current_resource = _resources[_current_resource_index]

func upgrade() -> void:
	if _current_resource_index < _resources.size()-1:
		_current_resource_index += 1

func downgrade() -> void:
	if _current_resource_index > 0:
		_current_resource_index -= 1

func shoot() -> void:
	for n in range(_current_resource.bullets):
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
