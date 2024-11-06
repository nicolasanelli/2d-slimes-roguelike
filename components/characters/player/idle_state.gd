extends NodeState


@export var happy_boo: HappyBoo


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	happy_boo.play_idle_animation()


func _on_next_transitions() -> void:
	if PlayerInput.is_movement():
		transition.emit("Walk")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
