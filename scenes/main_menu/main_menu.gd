extends Node2D


func _ready() -> void:
	AudioManager.play_background_music()


func _on_play_button_1_pressed() -> void:
	AudioManager.play_click()
	Loader.load_scene(self, "res://scenes/game_screen/game_screen.tscn")


func _on_play_button_2_pressed() -> void:
	AudioManager.play_click()
	Loader.load_scene(self, "res://scenes/game_screen_v2/game_screen_v2.tscn")
