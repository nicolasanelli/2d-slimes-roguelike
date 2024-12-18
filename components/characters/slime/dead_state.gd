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
	xp.set_experience_value(slime._resource.experience_drop)
	xp.global_position = slime.global_position
	slime.add_sibling(xp)
	
	slime.queue_free()
	if Debugger != null and Debugger.instance != null:
		Debugger.instance.increaseMobKilled()


func _on_next_transitions() -> void:
	pass


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	pass
