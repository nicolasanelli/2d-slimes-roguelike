class_name GameManager extends Node

#region Singleton
static var instance: GameManager

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		Global.toggle_pause()


func main_menu() -> void:
	Global.main_menu()


func start_game() -> void:
	Global.start_game()


func game_over() -> void:
	Global.game_over()
