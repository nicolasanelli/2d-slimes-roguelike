extends Node

func get_movement() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func is_movement() -> bool:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO
