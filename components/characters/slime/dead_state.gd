extends NodeState


@export var slime: Slime
@export var slime_body: SlimeBody


var _explosion_component = preload("res://components/efx/smoke_explosion/smoke_explosion.tscn")
var _xp_orb_componemt = preload("res://components/drops/xp_orb/xp_orb.tscn")


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var smoke: Node2D = _explosion_component.instantiate()
	smoke.global_position = slime.global_position
	slime.add_sibling(smoke)
	
	var xp: XpOrb = _xp_orb_componemt.instantiate()
	xp.set_experience_value(int(slime.get_experience_drop()))
	xp.global_position = slime.global_position
	DropManager.instance.spawn(xp, slime.global_position)
	
	slime.queue_free()
	Statistics.add_mob_killed()


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
