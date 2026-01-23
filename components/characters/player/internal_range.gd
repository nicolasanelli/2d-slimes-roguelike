class_name InternalRange
extends Area2D

@export var parent: Node2D;

func _ready() -> void:
	assert(parent != null, "Parent is not set in InternalRange")
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body is Slime:
		(body as Slime).take_damage(1)
