class_name Saw
extends Area2D


var _damage = 1
const ROTATION_SPEED = 12


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func set_damage(value: int) -> void:
	_damage = value


func _process(delta: float) -> void:
	rotation += ROTATION_SPEED * delta * GlobalTimer.get_factor()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(_damage)
