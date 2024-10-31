extends Node2D

@onready var game_manager: GameManager = %GameManager
@onready var card_manager: CardManager = $CardManager

@onready var _camera: Camera2D = $Player/Camera2D

#func _ready() -> void:
	#card_manager.card_picked.connect(_on_card_picked)


func _process(_delta: float) -> void:
	if game_manager._current_state == GameManager.GameState.RUNNING:
		card_manager.visible = false
	#
	#if game_manager._current_state == GameManager.GameState.PICKING:
		#card_manager.display_cards()

func _input(_event: InputEvent) -> void:
	if !_camera: return;
	
	var zoom_val = _camera.zoom.x
	if Input.is_action_just_pressed("zoom_in"):
		_camera.zoom = Vector2(zoom_val + 0.05, zoom_val + 0.05)
	if Input.is_action_just_pressed("zoom_out"):
		_camera.zoom = Vector2(max(0.1, zoom_val - 0.05), max(0.1, zoom_val - 0.05))


#func _on_card_picked() -> void:
	#game_manager._transition(GameManager.GameState.RUNNING)
