extends Node

func get_movement() -> Vector2:
	if Util.is_mobile():
		return Joystick.instance.get_vector()
	
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func is_movement() -> bool:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO
