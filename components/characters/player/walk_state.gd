extends NodeState


@export var player: Player
@export var happy_boo: HappyBoo
@export var speed: int = 600


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	happy_boo.play_walk_animation()
	
	var direction = PlayerInput.get_movement()
	player.velocity = direction * speed * GlobalTimer.get_factor()
	player.move_and_slide()


func _on_next_transitions() -> void:
	if !PlayerInput.is_movement():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
