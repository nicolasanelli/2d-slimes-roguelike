class_name Hitbox
extends Area2D

@export var damage: float = 1.0
@export var source: Node


func _ready() -> void:
	monitoring = false
	monitorable = true
	input_pickable = false
