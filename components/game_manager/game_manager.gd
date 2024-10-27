class_name GameManager extends Node

#region Singleton
static var instance: GameManager

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


func main_menu() -> void:
	Global.main_menu()


func start_game() -> void:
	Global.start_game()


func game_over() -> void:
	Global.game_over()
