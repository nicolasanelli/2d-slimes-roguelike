extends MarginContainer

@onready var exit_to_menu: Button = %ExitToMenu

func _ready() -> void:
	visible = false
	CommandDispatcher.game_paused.connect(_on_game_paused)
	CommandDispatcher.game_unpaused.connect(_on_game_unpaused)
	exit_to_menu.pressed.connect(_on_exit_to_menu)

func _on_game_paused() -> void:
	visible = true
	
func _on_game_unpaused() -> void:
	visible = false

func _on_exit_to_menu() -> void:
	AudioManager.play_click()
	CommandDispatcher.on_exit_game.emit()
