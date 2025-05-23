class_name HealthComponent
extends Node


signal healed
signal damaged
signal health_changed
signal health_depleted

var health_depleted_emited := false


@export var _max_health: float:
	set(value):
		_max_health = value
		if _current_health > _max_health:
			_current_health = _max_health


var _current_health: float:
	set(value):
		_current_health = clampf(value, 0, _max_health)
		health_changed.emit()
		if !health_depleted_emited && is_equal_approx(_current_health, 0):
			health_depleted_emited = true
			health_depleted.emit()


func _ready() -> void:
	_current_health = _max_health


func get_max_health() -> float:
	return _max_health;


func get_current_health() -> float:
	return _current_health;


func damage(value: float) -> void:
	damaged.emit()
	_current_health -= value


func heal(value: float) -> void:
	healed.emit()
	_current_health += value
