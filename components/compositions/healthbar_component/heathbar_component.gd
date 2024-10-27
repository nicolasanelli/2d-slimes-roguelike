class_name HealthbarComponent
extends Node2D


@export var _health_component: HealthComponent

@onready var _progress_bar: ProgressBar = %ProgressBar

func _ready() -> void:
	assert(_health_component != null, "HealthComponent must be set for HealthbarComponent")
	_health_component.health_changed.connect(_update_health_bar)
	_update_health_bar()


func _update_health_bar() -> void:
	_progress_bar.max_value = _health_component.get_max_health()
	_progress_bar.value = _health_component.get_current_health()
