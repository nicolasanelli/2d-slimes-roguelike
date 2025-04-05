extends MarginContainer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("show_debug"):
		visible = !visible
