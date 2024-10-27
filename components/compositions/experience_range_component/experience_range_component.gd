class_name ExperienceRangeComponent
extends Area2D


@export var _experience_component: ExperienceComponent


var _mapped_drops = {}


func _ready() -> void:
	assert(_experience_component != null, "ExperienceComponent must be set in ExperienceRangeComponent")


func _physics_process(_delta: float) -> void:
	var drops = get_overlapping_bodies()
	if drops.size() > 0:
		for n in drops.size():
			var drop: XpOrb = drops[n];
			drop.set_target_global_position(global_position)
			
			if _mapped_drops.has(drop.get_instance_id()) or drop.is_already_absorbed(): 
				continue
			
			drop.xp_absorved.connect(_process_experience_absorbed)
			_mapped_drops[drop.get_instance_id()] = true


func _process_experience_absorbed(instance_id:int, value: float) -> void:
	_experience_component.add_experience(value)
	_mapped_drops.erase(instance_id)
