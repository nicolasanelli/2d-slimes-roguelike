extends MarginContainer

func _ready() -> void:
	visible = false
	CommandDispatcher.game_paused.connect(_on_game_paused)
	CommandDispatcher.game_unpaused.connect(_on_game_unpaused)

func _on_game_paused() -> void:
	visible = true
	
func _on_game_unpaused() -> void:
	visible = false
