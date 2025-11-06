extends Node

var _mob_spawned: int = 0
var _mob_killed: int = 0
var _bullets_shooted: int = 0

var _running: bool = false
var _time_elapsed: float = 0.0


func _process(delta: float) -> void:
	if (_running):
		_time_elapsed += (delta * GlobalTimer.get_factor())

func stop_timer() -> void:
	_running = false

func reset_statistics() -> void:
	_mob_spawned = 0
	_mob_killed = 0
	_bullets_shooted = 0
	_time_elapsed = 0.0
	_running = true
	
func add_spawned_mob() -> void:
	_mob_spawned += 1
func add_mob_killed() -> void:
	_mob_killed += 1
func add_bullet_shooted() -> void:
	_bullets_shooted += 1

func get_spawned_mob() -> int:
	return _mob_spawned
func get_mob_killed() -> int:
	return _mob_killed
func get_bullet_shooted() -> int:
	return _bullets_shooted
func get_time_elapsed() -> float:
	return _time_elapsed
func get_time_elapsed_as_string() -> String:
	var minutes = int(_time_elapsed / 60)
	var seconds = int(_time_elapsed) % 60
	return "%02.0f:%02.0f" % [minutes, seconds]
