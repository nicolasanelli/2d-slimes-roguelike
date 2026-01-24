class_name ExperienceComponent


signal experience_changed(current: float, target: float, total: float)
signal leveled_up(new_level: int)


var _current_experience: float
var _current_level: int
var _target_experience: float
var _total_experience: float


func _init() -> void:
	_current_level = 0
	_current_experience = 0
	_total_experience = 0
	_target_experience = _calculate_next_target()


func add_experience(value: float) -> void:
	if value <= 0:
		return
		
	_total_experience += value
	_current_experience += value
	
	while _current_experience >= _target_experience:
		_current_experience -= _target_experience
		_current_level += 1
		_target_experience = _calculate_next_target()
		leveled_up.emit(_current_level)
	
	experience_changed.emit(_current_experience, _target_experience, _total_experience)


func _calculate_next_target() -> float:
	return round(pow(_current_level, 1.8) + _current_level + 5)
