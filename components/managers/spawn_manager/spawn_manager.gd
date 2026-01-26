class_name SpawnManager
extends Node

@export var max_mobs_alive := 30
@export var drop_manager: DropManager
var spawners: Array = []
var mobs_alive := 0

func _ready() -> void:
	spawners = get_tree().get_nodes_in_group("mob_spawners")

func _process(_delta: float) -> void:
	if mobs_alive >= max_mobs_alive:
		return

	_spawn_from_random_spawner()

func _spawn_from_random_spawner() -> void:
	if spawners.is_empty():
		return

	var spawner = spawners.pick_random()
	spawner.spawn(self, _on_mob_died)
	
	GameManager.run_stats.add_spawned_mob()
	mobs_alive += 1


func _on_mob_died(where: Vector2, xp_amount: float) -> void:
	GameManager.run_stats.add_mob_killed()
	drop_manager.spawn_xp(where, xp_amount)
	mobs_alive -= 1
