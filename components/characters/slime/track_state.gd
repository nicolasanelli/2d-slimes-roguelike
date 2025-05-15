extends NodeState


@export var slime: Slime
@export var slime_body: SlimeBody
@export var health_component: HealthComponent
@export var navigation_agent: NavigationAgent2D

@onready var timer: Timer = $Timer


func _on_process(_delta : float) -> void:
	pass

var direction: Vector2;
func _update_direction() -> void:
	navigation_agent.target_position = slime.get_target_global_position()
	direction = (navigation_agent.get_next_path_position() - slime.global_position).normalized()
	

func _on_physics_process(_delta: float) -> void:
	slime_body.play_walk()
	
	slime.velocity = direction * slime._resource.speed * GlobalTimer.get_factor()
	slime.move_and_slide()


func _on_next_transitions() -> void:
	if health_component.get_current_health() <= 0:
		transition.emit("Dead")
		
	if slime.get_distance_to_target() < 10:
		transition.emit("Idle")


func _on_enter() -> void:
	_update_direction()


func _on_exit() -> void:
	pass
