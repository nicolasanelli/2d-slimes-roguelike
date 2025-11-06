extends MarginContainer

@onready var exit_to_menu: Button = %ExitToMenu

func _ready() -> void:
	visible = false
	exit_to_menu.pressed.connect(_on_exit_to_menu)

func _input(_event: InputEvent) -> void:
	if _event.is_action_pressed("Pause"):
		_toggle_pause()

func _toggle_pause() -> void:
	if visible:
		visible = false
		CommandDispatcher.game_unpaused.emit()
	else:
		visible = true
		CommandDispatcher.game_paused.emit()

func _on_exit_to_menu() -> void:
	AudioManager.play_click()
	CommandDispatcher.on_exit_game.emit()
