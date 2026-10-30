extends Control

@onready var new_game_button: Button = $VBoxContainer/NewGameButton
@onready var load_game_button: Button = $VBoxContainer/LoadGameButton

func _ready() -> void:
	new_game_button.grab_focus(true)
