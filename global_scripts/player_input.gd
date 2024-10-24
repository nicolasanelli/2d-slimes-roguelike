extends Node

func get_movement() -> Vector2:
	if Global.is_mobile():
		return Joystick.instance.get_vector()
	
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")
