extends Area2D


var _bullet_component = preload("res://components/bullet/bullet.tscn")
@onready var _pistol_sprite: Sprite2D = %Pistol
@onready var _shooting_point: Marker2D = %ShootingPoint
@onready var _timer: Timer = $Timer


@export var _disabled: bool = false


var _attack_speed: float = 0.7


func _ready() -> void:
	_timer.wait_time = 1 / _attack_speed
	if not _disabled: _timer.start()
	_timer.timeout.connect(_on_timer_timeout)


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


func _on_timer_timeout() -> void:
	shoot()


func get_attack_speed() -> float:
	return _attack_speed


func increase_attack_speed() -> void:
	_attack_speed += .1
	_timer.wait_time = 1 / _attack_speed


func decrease_attack_speed() -> void:
	_attack_speed -= .1
	_timer.wait_time = 1 / _attack_speed


func shoot() -> void:
	var bullet: Node2D = _bullet_component.instantiate()
	bullet.global_position = _shooting_point.global_position
	bullet.global_rotation = _shooting_point.global_rotation
	Debugger.instance.increaseBulletsShooted()
	_shooting_point.add_child(bullet)
