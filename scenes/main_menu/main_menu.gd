extends Node

@onready var start_button: Button = %StartButton
@onready var achievements_button: Button = %AchievementsButton
@onready var options_button: Button = %OptionsButton
@onready var credits_button: Button = %CreditsButton
@onready var exit_button: Button = %ExitButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)


func _on_start_button_pressed() -> void:
	Loader.load_scene("res://scenes/game_scene/game_scene.tscn")

func _on_options_button_pressed() -> void:
	Loader.load_scene("res://scenes/options_menu/options_menu.tscn")
