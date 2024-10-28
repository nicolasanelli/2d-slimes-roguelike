extends Node2D


func _on_replay_button_pressed() -> void:
	Global.start_game()


func _on_exit_button_pressed() -> void:
	Global.main_menu()
