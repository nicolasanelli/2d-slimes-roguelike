class_name HurtboxComponent
extends Area2D


#signal hit_by_bullet
signal hit_by_hitbox


@export var _health_component: HealthComponent


func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	if bodies.size() > 0:
		var damage = 0;
		for n in range(bodies.size()):
			var body = bodies[n]
			if !body.has_method("get_damage"):
				push_error("Body without 'get_damage' got captured by hurtbox")
				continue;
				
			damage += body.get_damage() * delta * GlobalTimer.get_factor()
		
		_health_component.damage(damage)
		hit_by_hitbox.emit()
