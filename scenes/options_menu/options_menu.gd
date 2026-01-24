extends Node


@onready var back_button: Button = %BackButton


func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)


func _on_back_button_pressed() -> void:
	Loader.load_scene(self, Constants.SCENE_PATH.main_menu)
