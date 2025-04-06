extends Node2D

@onready var _card_manager: CardManager = $CardManager
@onready var _camera: Camera2D = $Player/Camera2D

enum GameState {
	RUNNING,
	PICKING,
	GAMEOVER,
	VICTORY
}

var _current_state: GameState = GameState.RUNNING
var _should_pick_card_times = 0
var _paused := false

func _ready() -> void:
	GlobalTimer.set_target_factor(1)
	Statistics.reset_statistics()
	AudioManager.stick_to(_camera)
	_connect_signals()

func _process(_delta: float) -> void:
	if _current_state == GameState.RUNNING:
		_card_manager.visible = false
		
		if _should_pick_card_times > 0:
			_pick_card()

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
			AudioManager.play_levelup()
			GlobalTimer.set_target_factor(0, 2)
		GameState.GAMEOVER:
			Statistics.stop_timer()
			AudioManager.stop_all_sfx()
			Loader.load_scene(self, "res://scenes/game_over/game_over.tscn")
		GameState.VICTORY:
			Statistics.stop_timer()
			AudioManager.stop_all_sfx()
			Loader.load_scene(self, "res://scenes/victory/victory.tscn")



func _toggle_pause() -> void:
	if _paused:
		GlobalTimer.unpause()
		CommandDispatcher.game_unpaused.emit()
	else:
		GlobalTimer.pause()
		CommandDispatcher.game_paused.emit()
		
	_paused = !_paused


func _connect_signals() -> void:
	CommandDispatcher.player_died.connect(_on_player_died)
	CommandDispatcher.player_leveled.connect(_on_player_leveled)
	CommandDispatcher.card_executed.connect(_on_card_executed)
	CommandDispatcher.victory.connect(_on_victory)


func _on_player_died() -> void:
	_transition(GameState.GAMEOVER)


func _on_player_leveled(_level: int) -> void:
	_should_pick_card_times += 1


func _pick_card() -> void:
	_should_pick_card_times = max(0, _should_pick_card_times-1)
	
	_transition(GameState.PICKING)
	_card_manager.display_cards()
	

func _on_card_executed() -> void:
	_transition(GameState.RUNNING)


func _on_victory() -> void:
	_transition(GameState.VICTORY)
