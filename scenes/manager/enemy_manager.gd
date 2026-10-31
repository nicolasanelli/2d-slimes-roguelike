extends Node

const SPAWN_RADIUS := 375

@export var basic_enemy: PackedScene

@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player := get_tree().get_first_node_in_group("Player") as Player
	if player == null:
		push_warning("Player not found at EnemyManager")
		return
	
	var random_direction := Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position := player.global_position + (random_direction * SPAWN_RADIUS)
	
	var enemy: Node2D = basic_enemy.instantiate()
	get_parent().add_child(enemy) # TODO Consider using a dedicated enemy container node instead of adding directly to the parent
	enemy.global_position = spawn_position
