extends Node2D


@onready var area_2d: Area2D = $Area2D


func _ready() -> void:
	area_2d.area_entered.connect(_on_area_entered)


func _on_area_entered(other_area: Area2D):
	GameEvents.emit_experience_vial_collected(1.0)
	queue_free()
