class_name ShotgunBullet 
extends Area2D


var _damage = 1
var _max_range = 500
var _max_hits = 1

var _current_hits = 0
var _travelled_distance = 0


const SPEED = 1000


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func set_damage(value: int) -> void:
	_damage = value

func set_max_range(value: int) -> void:
	_max_range = value

func set_as_special() -> void:
	_max_hits = 2


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var move = SPEED * delta * GlobalTimer.get_factor()
	position += direction * move
	
	_travelled_distance += move
	if _travelled_distance > _max_range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	_current_hits += 1
	
	if (_current_hits >= _max_hits):
		queue_free()
		
	if body.has_method("take_damage"):
		body.take_damage(_damage)
		
