extends Node2D

@onready var _card_manager: CardManager = $CardManager
@onready var _camera: Camera2D = $Player/Camera2D
@onready var _player: Player = $Player

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

func _process(_delta: float) -> void:
	if _current_state == GameState.RUNNING:
		_card_manager.visible = false

func _input(_event: InputEvent) -> void:
	if _event.is_action_pressed("Pause"):
		_toggle_pause()
	
	if !_camera: return;
	
	var zoom_val = _camera.zoom.x
	if Input.is_action_just_pressed("zoom_in"):
		_camera.zoom = Vector2(zoom_val + 0.05, zoom_val + 0.05)
	if Input.is_action_just_pressed("zoom_out"):
		_camera.zoom = Vector2(max(0.1, zoom_val - 0.05), max(0.1, zoom_val - 0.05))

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
			Loader.load_scene(self, "res://scenes/game_over/game_over.tscn")
		GameState.VICTORY:
			pass


var paused: bool;
func _toggle_pause() -> void:
	if paused:
		GlobalTimer.set_target_factor(1, .75)
	else:
		GlobalTimer.set_target_factor(0)
	paused = !paused


func _connect_signals() -> void:
	_player.player_died.connect(_on_player_died)
	_player.player_leveled.connect(_on_player_leveled)
	_card_manager.card_picked.connect(_on_card_picked)


func _on_player_died() -> void:
	_transition(GameState.GAMEOVER)


func _on_player_leveled() -> void:
	_transition(GameState.PICKING)
	_card_manager.display_cards()


func _on_card_picked() -> void:
	_transition(GameState.RUNNING)
