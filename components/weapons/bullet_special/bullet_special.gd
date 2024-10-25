class_name BulletSpecial extends Area2D


var _damage = 1
var _travelled_distance = 0


const SPEED = 1000
const MAX_RANGE = 3240


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func set_damage(value: int) -> void:
	_damage = value


func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	_travelled_distance += SPEED * delta
	if _travelled_distance > MAX_RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		queue_free()
		body.take_damage(_damage)
	
	rotation += (PI * randf())
		
