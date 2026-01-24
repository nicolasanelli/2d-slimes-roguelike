extends Node


@onready var start_button: Button = %StartButton
@onready var achievements_button: Button = %AchievementsButton
@onready var options_button: Button = %OptionsButton
@onready var credits_button: Button = %CreditsButton
@onready var exit_button: Button = %ExitButton


func _ready() -> void:
	start_button.pressed.connect(_on_start_button_pressed)
	achievements_button.pressed.connect(_on_achievements_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)


func _on_start_button_pressed() -> void:
	GameManager.start_new_run()
	Loader.load_scene(self, Constants.SCENE_PATH.stage_one)


func _on_achievements_button_pressed() -> void:
	print("Achievements Button Pressed")


func _on_options_button_pressed() -> void:
	Loader.load_scene(self, Constants.SCENE_PATH.options_menu)


func _on_credits_button_pressed() -> void:
	print("Credits Button Pressed")


func _on_exit_button_pressed() -> void:
	get_tree().quit()
