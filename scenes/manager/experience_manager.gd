extends Node

var current_experience = 0;


func _ready() -> void:
	GameEvents.experience_vial_collected.connect(_on_experience_vial_collected)


func increment_experience(value: float) -> void:
	current_experience += value
	print(current_experience)


func _on_experience_vial_collected(value: float) -> void:
	increment_experience(value)
