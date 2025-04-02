class_name Slime
extends CharacterBody2D


@export var _resource: SlimeResource
@export var target: Node2D

@onready var health_component: HealthComponent = %HealthComponent
@onready var _slime_body: SlimeBody = %SlimeBody


#region Engine
func _ready() -> void:
	assert(_resource != null, "SlimeResource is not set in Slime")
	var player_lvl = 0;
	if (target):
		player_lvl = (target as Player)._experience_component.get_current_level()
	health_component._max_health = roundi(_resource.health + (player_lvl * 1.1))
	health_component._current_health = health_component._max_health
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


func set_target(_target: Node2D) -> void:
	target = _target;


func get_distance_to_target() -> float:
	if target == null: return 0
	
	return global_position.distance_to(target.global_position)

func get_direction_to_target() -> Vector2:
	if target == null: return Vector2.ZERO
	
	return global_position.direction_to(target.global_position)


func set_resource(resource: SlimeResource) -> void:
	_resource = resource;


func get_damage() -> float:
	return _resource.damage


func take_damage(amount: float = 1.0) -> void:
	health_component.damage(amount)
	_slime_body.play_hurt()
