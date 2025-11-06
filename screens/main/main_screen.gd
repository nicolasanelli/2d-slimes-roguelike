class_name MainScreen
extends Node

@onready var container := %Container


func _ready() -> void:
	Global.main = self
	AudioManager.play_background_music()
	Loader.set_container(container)
	Loader.load_scene("res://scenes/main_menu/main_menu.tscn")
