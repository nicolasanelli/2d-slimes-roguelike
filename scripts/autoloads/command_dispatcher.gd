@warning_ignore_start("unused_signal")
extends Node


signal game_paused
signal game_unpaused
signal on_exit_game

signal player_leveled(component: ExperienceComponent)
signal player_experience_changed(component: ExperienceComponent)
signal player_health_changed(component: HealthComponent)
signal player_died
