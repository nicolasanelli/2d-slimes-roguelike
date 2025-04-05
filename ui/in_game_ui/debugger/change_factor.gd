class_name ChangeFactor
extends Button

static var factor = 1
@export var value := 1.0 
@export var step := 10.0

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	if value == 1: 
		ChangeFactor.factor = 1
	else:
		ChangeFactor.factor += value
	
	GlobalTimer.set_target_factor(factor, step)
