extends CharacterBody2D

const MAX_SPEED = 40
const DISTANCE_OFFSET = 3


@onready var slime_body: SlimeBody = $SlimeBody
@onready var area_2d: Area2D = $Area2D
@onready var health_component: HealthComponent = $HealthComponent


func _ready() -> void:
	slime_body.play_walk()
	area_2d.area_entered.connect(_on_area_entered)
	health_component.died.connect(queue_free)


func _process(_delta: float) -> void:
	var direction := get_direction_to_player()
	
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_direction_to_player() -> Vector2:
	var player := get_tree().get_first_node_in_group("Player") as Player
	if player == null || global_position.distance_squared_to(player.global_position) < pow(DISTANCE_OFFSET, 2): 
		return Vector2.ZERO
	
	return (player.global_position - global_position).normalized()


func _on_area_entered(_other_area: Node2D) -> void:
	health_component.damage(100)
