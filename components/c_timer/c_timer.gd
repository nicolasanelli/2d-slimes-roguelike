class_name CTimer 
extends Node


signal timeout


@export var process_callback: TimerProcessCallback = TimerProcessCallback.PROCESS
@export_range(0.001, 4096) var wait_time: float = 1
@export var one_shot: bool = false
@export var autostart: bool = false

var _processing: bool = false
var paused: bool = false

var time_left: float = -1.0:
	set(value):
		time_left = value
		if time_left <= 0:
			timeout.emit()
			if !one_shot: 
				time_left = wait_time


enum TimerProcessCallback {
	PHYSICS_PROCESS,
	PROCESS
}


func _ready() -> void:
	if autostart: start()


func _physics_process(delta: float) -> void:
	if process_callback == TimerProcessCallback.PHYSICS_PROCESS and _processing and !paused:
		time_left -= delta * GlobalTimer.get_speed_factor()

func _process(delta: float) -> void:
	if process_callback == TimerProcessCallback.PROCESS and _processing and !paused:
		time_left -= delta * GlobalTimer.get_speed_factor()


func start() -> void:
	_processing = true
	time_left = wait_time

func stop() -> void:
	_processing = false
	time_left = 0


func is_paused() -> bool:
	return paused

func is_stopped() -> bool:
	return !_processing
