extends Node2D


func _on_replay_button_pressed() -> void:
	Loader.load_scene(self, "res://scenes/game_screen/game_screen.tscn")


func _on_exit_button_pressed() -> void:
	Loader.load_scene(self, "res://scenes/main_menu/main_menu.tscn")
