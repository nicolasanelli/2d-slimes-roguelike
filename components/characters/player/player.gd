class_name Player
extends CharacterBody2D


@onready var _health_component: HealthComponent = %HealthComponent
@onready var _experience_component: ExperienceComponent = %ExperienceComponent


func _ready() -> void:
	_health_component.health_depleted.connect(_on_health_depleted)
	_health_component.damaged.connect(_on_damaged)
	_health_component.healed.connect(_on_healed)
	_experience_component.leveled_up.connect(_on_leveled_up)


func _on_health_depleted() -> void:
	AudioManager.play_gameover()
	CommandDispatcher.player_died.emit()

func _on_damaged() -> void:
	AudioManager.play_hurt()

func _on_healed() -> void:
	AudioManager.play_heal()

func _on_leveled_up() -> void:
	AudioManager.play_levelup()
	CommandDispatcher.player_leveled.emit(
		_experience_component.get_current_level()
	)
