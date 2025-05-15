class_name Player
extends CharacterBody2D


@onready var health_component: HealthComponent = %HealthComponent
@onready var experience_component: ExperienceComponent = %ExperienceComponent


func _ready() -> void:
	health_component.init(100)
	health_component.health_depleted.connect(_on_health_depleted)
	health_component.damaged.connect(_on_damaged)
	health_component.healed.connect(_on_healed)
	experience_component.leveled_up.connect(_on_leveled_up)


func _on_health_depleted() -> void:
	AudioManager.play_gameover()
	CommandDispatcher.player_died.emit()

func _on_damaged() -> void:
	if GlobalTimer.get_factor() > 0:
		AudioManager.play_hurt()

func _on_healed() -> void:
	AudioManager.play_heal()

func _on_leveled_up() -> void:
	CommandDispatcher.player_leveled.emit(
		experience_component.get_current_level()
	)
