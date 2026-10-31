extends Node
class_name HealthComponent

signal died

@export var max_health = 10
var current_health


func _ready() -> void:
	current_health = max_health


func damage(value: float) -> void:
	current_health = max(0, current_health - value)
	Callable(check_death).call_deferred()


func check_death() -> void:
	if current_health == 0:
		died.emit()
		#owner.queue_free() # Questionável
	
