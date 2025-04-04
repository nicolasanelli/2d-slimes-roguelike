extends Node2D


func _ready() -> void:
	AudioManager.play_background_music()


func _on_play_button_pressed() -> void:
	AudioManager.play_click()
	Loader.load_scene(self, "res://scenes/game_screen/game_screen.tscn")
