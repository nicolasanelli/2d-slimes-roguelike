extends Node2D


var player: Player
var run_stats: RunStats
@export var spawn_point: Vector2 = Vector2(960, 540)


func _ready() -> void:
	player = GameManager.player
	run_stats = GameManager.run_stats
	
	spawn_player()
	_connect_signals()


func _process(delta: float) -> void:
	run_stats.update_time_elapsed(delta)


func _connect_signals() -> void:
	CommandDispatcher.game_paused.connect(_on_game_paused)
	CommandDispatcher.game_unpaused.connect(_on_game_unpaused)
	CommandDispatcher.on_exit_game.connect(_on_exit_game)


func spawn_player() -> void:
	if player.get_parent():
		player.get_parent().remove_child(player)
	
	#AudioManager.stick_to(player)
	player.global_position = spawn_point
	add_child(player)


func _on_game_paused() -> void:
	get_tree().paused = true


func _on_game_unpaused() -> void:
	get_tree().paused = false


func _on_exit_game() -> void:
	GameManager.end_run()
	Loader.load_scene(self, Constants.SCENE_PATH.main_menu)


func _on_player_died() -> void:
	print("Player died")


func _on_player_leveled(_component: ExperienceComponent) -> void:
	print("Player Leveled")
