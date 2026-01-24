class_name DropManager
extends Node2D

var xp_orb_ps: PackedScene = preload(Constants.SCENE_PATH.xp_orb)

func spawn_xp(spawn_position: Vector2, amount: float) -> void:
	var orb = (xp_orb_ps.instantiate() as XpOrb)
	orb.global_position = spawn_position
	orb.set_experience_value(amount)
	add_child(orb)
