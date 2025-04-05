extends Node

var _is_paused := false
var _current_factor: float = 1
var _target_factor: float = 1
var _step: float = 0.4


func pause() -> void:
	_is_paused = true

func unpause() -> void:
	_is_paused = false
	var current = _current_factor
	_current_factor = 0
	set_target_factor(current, .75)
	


func get_factor() -> float:
	if (_is_paused): return 0.0
	
	return _current_factor


func set_target_factor(factor: float, step: float = 10) -> void:
	_target_factor = factor
	if step > 0:
		_step = clampf(step, 0, 10)


func _physics_process(delta: float) -> void:
	var diff = absf(_current_factor) - absf(_target_factor)
	if absf(diff) < 0.1 and diff != 0:
		_current_factor = _target_factor
	elif _target_factor < _current_factor:
		_current_factor -= _step * delta
	elif _target_factor > _current_factor:
		_current_factor += _step * delta
