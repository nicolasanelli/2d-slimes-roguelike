extends CharacterBody2D

const MAX_SPEED = 75
const DISTANCE_OFFSET = 3


@onready var slime_body: SlimeBody = $SlimeBody


func _ready() -> void:
	slime_body.play_walk()


func _process(delta: float) -> void:
	var direction = get_direction_to_player()
	
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	var player = get_tree().get_first_node_in_group("Player") as Player
	if player == null || global_position.distance_to(player.global_position) < DISTANCE_OFFSET: 
		return Vector2.ZERO
	
	return (player.global_position - global_position).normalized()
