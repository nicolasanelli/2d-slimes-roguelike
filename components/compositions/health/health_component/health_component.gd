class_name HealthComponent


signal healed(amount: float)
signal damaged(amount: float)
signal health_changed(current: float, max: float)
signal health_depleted


var health_depleted_emited := false


var _max_health: float:
	set(value):
		_max_health = max(value, 0.0)
		if _current_health > _max_health: 
			_current_health = _max_health


var _current_health: float:
	set(value):
		_current_health = clampf(value, 0, _max_health)
		health_changed.emit(_current_health, _max_health)
		if !health_depleted_emited && is_equal_approx(_current_health, 0):
			health_depleted_emited = true
			health_depleted.emit()


func _init(initial_health: float) -> void:
	_max_health = initial_health
	_current_health = initial_health


func is_alive() -> bool:
	return !health_depleted_emited


func damage(amount: float) -> void:
	if amount <= 0.0 or !is_alive():
		return

	_current_health -= amount

	if _current_health > 0.0:
		damaged.emit(amount)


func heal(amount: float) -> void:
	if amount <= 0.0 or !is_alive():
		return

	var previous_health := _current_health
	_current_health += amount

	# Emit only if actual healing happened
	if _current_health > previous_health:
		healed.emit(amount)


#region getters
func get_max_health() -> float:
	return _max_health;


func get_current_health() -> float:
	return _current_health;
#endregion
