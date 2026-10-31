extends Area2D
class_name HurtboxComponent

@export var health_component: HealthComponent


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(other_area: Area2D) -> void:
	if not other_area is HitboxComponent:
		push_warning("Area entered is not a HitboxComponent at HurtboxComponent")
		return
	
	if health_component == null:
		push_warning("HurtboxComponent has no HealthComponent assigned")
		return
	
	var hitbox_component: HitboxComponent = other_area
	health_component.damage(hitbox_component.damage)
