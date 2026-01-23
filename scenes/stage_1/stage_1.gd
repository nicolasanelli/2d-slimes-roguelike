extends Node2D


@onready var player: Player = %Player


func _ready() -> void:
	GameManager.start_new_run()
	GameManager.player = player
	#AudioManager.stick_to(player)
	_connect_signals()


func _connect_signals() -> void:
	CommandDispatcher.game_paused.connect(_on_game_paused)
	CommandDispatcher.game_unpaused.connect(_on_game_unpaused)
	CommandDispatcher.on_exit_game.connect(_on_exit_game)
	
	CommandDispatcher.player_leveled.connect(_on_player_leveled)
	CommandDispatcher.player_died.connect(_on_player_died)


func _on_game_paused() -> void:
	get_tree().paused = true


func _on_game_unpaused() -> void:
	get_tree().paused = false


func _on_exit_game() -> void:
	Loader.load_scene(self, "res://scenes/main_menu/main_menu.tscn")


func _on_player_died() -> void:
	print("Player died")


func _on_player_leveled(_component: ExperienceComponent) -> void:
	print("Player Leveled")
