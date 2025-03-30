extends Node2D


func _on_play_button_pressed() -> void:
	Loader.load_scene(self, "res://scenes/game_screen/game_screen.tscn")
