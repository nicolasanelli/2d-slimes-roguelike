class_name GameManager extends Node

#region Singleton
static var instance: GameManager

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


func _on_replay_pressed() -> void:
	Global.reset_game()


func game_over() -> void:
	Global.game_over()
