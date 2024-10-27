extends Node


var _current_factor: float = 1
var _target_factor: float = 1
var _step: float = 0.4


func get_factor() -> float:
	return _current_factor


func set_target_factor(factor: float, step: float = 10) -> void:
	_target_factor = factor
	if step > 0:
		_step = clampf(step, 0, 10)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("BB"):
		set_target_factor(1, 0.6)
	if event.is_action_pressed("AA"):
		set_target_factor(0)


func _physics_process(delta: float) -> void:
	var diff = absf(_current_factor) - absf(_target_factor)
	if absf(diff) < 0.05 and diff != 0:
		_current_factor = _target_factor
	elif _target_factor < _current_factor:
		_current_factor -= _step * delta
	elif _target_factor > _current_factor:
		_current_factor += _step * delta
