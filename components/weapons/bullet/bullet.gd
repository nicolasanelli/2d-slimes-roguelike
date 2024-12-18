class_name Bullet 
extends Area2D


var _damage = 1
var _travelled_distance = 0


const SPEED = 1000
const MAX_RANGE = 1080


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func set_damage(value: int) -> void:
	_damage = value


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	var move = SPEED * delta * GlobalTimer.get_factor()
	position += direction * move
	
	_travelled_distance += move
	if _travelled_distance > MAX_RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage(_damage)
		
