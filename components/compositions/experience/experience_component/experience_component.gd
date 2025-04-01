class_name ExperienceComponent
extends Node


signal experience_changed
signal leveled_up


var _target_experience: float:
	set(value):
		_target_experience = value

var _total_experience: float

var _current_experience: float:
	set(value):
		_current_experience = max(value, 0)
		experience_changed.emit()

var _current_level: int:
	set(value):
		_current_level = value
		leveled_up.emit()


func _ready() -> void:
	_current_level = 0
	_target_experience = _calculate_next_target()

func get_current_level() -> int:
	return _current_level


func get_target_experience() -> float:
	return _target_experience


func get_current_experience() -> float:
	return _current_experience


func get_total_experience() -> float:
	return _total_experience


func add_experience(value: float) -> void:
	_current_experience += value
	_total_experience += value
	
	while _current_experience >= _target_experience:
		_current_experience -= _target_experience
		level_up()

func level_up() -> void:
	_current_level += 1
	_target_experience = _calculate_next_target()


func _calculate_next_target() -> float:
	return round(pow(_current_level, 1.8) + _current_level + 5)
