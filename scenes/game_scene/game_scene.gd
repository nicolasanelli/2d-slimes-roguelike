extends Node2D


@onready var player: Player = %Player


func _ready() -> void:
	GlobalTimer.set_target_factor(1)
	GlobalTimer.resume()
	Statistics.reset_statistics()
	Global.player = player
	AudioManager.stick_to(player)
	_connect_signals()


func _connect_signals() -> void:
	CommandDispatcher.game_paused.connect(_on_game_paused)
	CommandDispatcher.game_unpaused.connect(_on_game_unpaused)
	CommandDispatcher.on_exit_game.connect(_on_exit_game)
	
	CommandDispatcher.player_leveled.connect(_on_player_leveled)
	CommandDispatcher.player_died.connect(_on_player_died)


func _on_game_paused() -> void:
	GlobalTimer.pause()

func _on_game_unpaused() -> void:
	GlobalTimer.resume()
	
func _on_exit_game() -> void:
	Loader.load_scene("res://scenes/main_menu/main_menu.tscn")


func _on_player_died() -> void:
	pass

func _on_player_leveled(_component: ExperienceComponent) -> void:
	pass
