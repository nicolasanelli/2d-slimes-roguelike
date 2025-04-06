class_name Slime
extends CharacterBody2D

signal health_depleted

@export var _resource: SlimeResource
@export var target: Node2D

@onready var health_component: HealthComponent = %HealthComponent
@onready var _slime_body: SlimeBody = %SlimeBody
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var _multiplier := 1

#region Engine
func _ready() -> void:
	assert(_resource != null, "SlimeResource is not set in Slime")
	Statistics.add_spawned_mob()
	health_component._max_health = (_resource.health * _multiplier)
	health_component._current_health = (_resource.health * _multiplier)
	health_component.health_depleted.connect(health_depleted.emit)
	_update_appearance()


func _process(_delta: float) -> void:
	$Label.text = "%s|%s" % [health_component.get_current_health(), health_component.get_max_health()]
#endregion


func _update_appearance() -> void:
	_slime_body.set_appearance(
		_resource.color, 
		_resource.hurt_color, 
		_resource.scale
	)
	collision_shape_2d.scale = _resource.scale 


func set_target(_target: Node2D) -> void:
	target = _target;


func get_distance_to_target() -> float:
	if target == null: return 0
	
	return global_position.distance_to(target.global_position)

func get_direction_to_target() -> Vector2:
	if target == null: return Vector2.ZERO
	
	return global_position.direction_to(target.global_position)


func set_resource(resource: SlimeResource, multiplier := 1) -> void:
	_resource = resource;
	_multiplier = multiplier


func get_damage() -> float:
	return (_resource.damage * _multiplier)


func get_experience_drop() -> float:
	return (_resource.experience_drop * _multiplier)


func take_damage(amount: float = 1.0) -> void:
	health_component.damage(amount)
	_slime_body.play_hurt()
	AudioManager.play_slime_squish()
