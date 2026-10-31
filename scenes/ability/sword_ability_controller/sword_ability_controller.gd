extends Node

const MAX_RANGE = 150

@export var sword_ability: PackedScene
@onready var timer: Timer = $Timer

var damage = 5

func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("Player") as Player
	if player == null: return
	
	var enemies = get_tree().get_nodes_in_group("Enemy")
	
	enemies = enemies.filter(func (enemy: Node2D):
		return enemy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	
	if enemies.size() == 0: return
	
	enemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = a.global_position.distance_squared_to(player.global_position)
		var b_distance = b.global_position.distance_squared_to(player.global_position)	
		
		return a_distance < b_distance
	)
	var target_enemy = enemies[0]
	#var target_enemy = enemies.pick_random() as Node2D
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	player.add_sibling(sword_instance)
	sword_instance.hitbox_component.damage = damage
	
	sword_instance.global_position = target_enemy.global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_direction = target_enemy.global_position - sword_instance.global_position
	sword_instance.rotation = enemy_direction.angle()
