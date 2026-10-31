extends Node
class_name ArenaTimeManager

@onready var timer: Timer = $Timer


func get_time_elapsed() -> float:
	return timer.wait_time - timer.time_left
