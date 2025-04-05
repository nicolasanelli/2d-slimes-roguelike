extends Node

func get_movement() -> Vector2:
	var joystick = Joystick.instance.get_vector()
	if joystick != Vector2.ZERO:
		return joystick
	
	return Input.get_vector("move_left", "move_right", "move_up", "move_down")


func is_movement() -> bool:
	var joystick = Joystick.instance.get_vector()
	if joystick != Vector2.ZERO:
		return true
		
	return Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO
