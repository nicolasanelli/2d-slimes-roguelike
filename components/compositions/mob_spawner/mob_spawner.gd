class_name MobSpawner
extends Node2D


@export var mob_scene: PackedScene


func _ready() -> void:
	$ColorRect.hide()

func spawn(parent: Node, _on_mob_died_callback: Callable) -> void:
	var mob = mob_scene.instantiate()
	if (mob.has_signal("died")):
		mob.died.connect(_on_mob_died_callback)
	mob.global_position = global_position 
	#+ Vector2(
		#randf_range(-spawn_radius, spawn_radius),
		#randf_range(-spawn_radius, spawn_radius)
	#)
	parent.add_child(mob)
