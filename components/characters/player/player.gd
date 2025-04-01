class_name Player
extends CharacterBody2D


@onready var _health_component: HealthComponent = %HealthComponent
@onready var _experience_component: ExperienceComponent = %ExperienceComponent


func _ready() -> void:
	_health_component.health_depleted.connect(_on_health_depleted)
	_experience_component.leveled_up.connect(_on_leveled_up)


func _on_health_depleted() -> void:
	## play animation, sounds, efx
	CommandDispatcher.player_died.emit()


func _on_leveled_up() -> void:
	## play animation, sound, efx
	CommandDispatcher.player_leveled.emit()
