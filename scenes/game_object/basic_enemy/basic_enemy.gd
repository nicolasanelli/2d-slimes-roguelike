extends CharacterBody2D

const MAX_SPEED: int = 40
const DISTANCE_OFFSET: int = 3


@onready var slime_body: SlimeBody = $SlimeBody
@onready var health_component: HealthComponent = $HealthComponent


func _ready() -> void:
	slime_body.play_walk()
	health_component.died.connect(queue_free)


func _process(_delta: float) -> void:
	var direction := get_direction_to_player()
	
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	var player: Player = get_tree().get_first_node_in_group("Player")
	if player == null:
		push_warning("Player not found at BasicEnemy")
		return Vector2.ZERO
	
	if global_position.distance_squared_to(player.global_position) < pow(DISTANCE_OFFSET, 2): 
		return Vector2.ZERO
	
	return (player.global_position - global_position).normalized()
