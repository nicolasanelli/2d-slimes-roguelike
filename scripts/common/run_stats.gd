class_name RunStats


var _mob_spawned: int = 0
var _mob_killed: int = 0
var _bullets_shooted: int = 0
var _time_elapsed: float = 0.0


func add_spawned_mob() -> void:
	_mob_spawned += 1


func add_mob_killed() -> void:
	_mob_killed += 1


func add_bullet_shot() -> void:
	_bullets_shooted += 1


func update_time_elapsed(delta: float) -> void:
	_time_elapsed += delta
	

func get_spawned_mob() -> int:
	return _mob_spawned


func get_mob_killed() -> int:
	return _mob_killed


func get_bullets_shot() -> int:
	return _bullets_shooted


func get_time_elapsed() -> float:
	return _time_elapsed


func get_time_elapsed_as_string() -> String:
	var total_seconds := int(_time_elapsed)
	var minutes := total_seconds / 60.0
	var seconds := total_seconds % 60
	
	return "%02d:%02d" % [minutes, seconds]
