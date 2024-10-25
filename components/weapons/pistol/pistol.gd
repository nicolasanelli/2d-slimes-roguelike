class_name Pistol extends Area2D


var _bullet_component = preload("res://components/weapons/bullet/bullet.gd")
var _bullet_special_component = preload("res://components/weapons/bullet_special/bullet_special.tscn")
@onready var _pistol_sprite: Sprite2D = %Pistol
@onready var _shooting_point: Marker2D = %ShootingPoint
@onready var _timer: Timer = $Timer

@export var _resource: PistolResource
@export var _disabled: bool = false


var _damage: int
var _bullets: int
var _bullets_max_range: int
var _attack_speed: float
var _rarity: int


func _ready() -> void:
	_damage = _resource.damage
	_bullets = _resource.bullets
	_bullets_max_range = _resource.bullet_max_range
	_attack_speed = _resource.attack_speed
	_rarity = _resource.rarity
	
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
	var enemies_in_range: Array[Node2D] = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		var target = enemies_in_range.front()
		look_at(target.global_position)


func _configure_timer() -> void:
	if _disabled: return
	
	_timer.start()
	_timer.wait_time = 1 / _attack_speed
	_timer.timeout.connect(_on_timer_timeout)
func _on_timer_timeout() -> void:
	shoot()
	
func shoot() -> void:
	for n in range(_bullets):
		Debugger.instance.increaseBulletsShooted()
		
		var bullet
		if _resource.special:
			bullet = _bullet_special_component.instantiate()
		else:
			bullet = _bullet_component.instantiate()
		
		bullet.global_position = _shooting_point.global_position
		bullet.global_rotation = _shooting_point.global_rotation
		
		bullet.set_damage(_resource.damage)
		bullet.set_max_range(_resource.bullet_max_range)
		
		_shooting_point.add_child(bullet)
		await get_tree().create_timer(0.03).timeout
