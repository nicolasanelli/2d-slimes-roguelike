class_name GameManager
extends Node


@export var _player: Player


enum GameState {
	RUNNING,
	PICKING,
	GAMEOVER,
	VICTORY
}

var _current_state: GameState = GameState.RUNNING


func _ready() -> void:
	assert(_player != null, "Player is not set in GameManager")
	_connect_signals()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		Global.toggle_pause()


func _transition(next_state: GameState) -> void:
	
	#match _current_state:
		#GameState.RUNNING:
			#pass
		#GameState.PICKING:
			#pass
		#GameState.GAMEOVER:
			#pass
		#GameState.VICTORY:
			#pass
	
	_current_state = next_state
	
	match _current_state:
		GameState.RUNNING:
			GlobalTimer.set_target_factor(1, .4)
		GameState.PICKING:
			GlobalTimer.set_target_factor(0, 2)
		GameState.GAMEOVER:
			Global.game_over()
		GameState.VICTORY:
			pass


func _connect_signals() -> void:
	_player.player_died.connect(_on_player_died)
	_player.player_leveled.connect(_on_player_leveled)


func _on_player_died() -> void:
	_transition(GameState.GAMEOVER)


func _on_player_leveled() -> void:
	_transition(GameState.PICKING)
