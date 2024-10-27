class_name CTimer 
extends Node


signal timeout



@export_range(0.001, 4096) var wait_time: float = 1
func set_wait_time(value: float) -> void:
	wait_time = value
func get_wait_time() -> float:
	return wait_time


var _processing: bool = false


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


func start(time_sec: float = -1) -> void:
	if time_sec > 0:
		time_left = time_sec
	else:
		time_left = wait_time
	_processing = true

func stop() -> void:
	_processing = false
	time_left = 0
	
func is_stopped() -> bool:
	return !_processing


@export var autostart: bool = false
func set_autostart(value: bool) -> void:
	autostart = value
func has_autostsart() -> bool:
	return autostart


@export var one_shot: bool = false
func set_one_shot(value: bool) -> void:
	one_shot = value
func is_one_shot() -> bool:
	return one_shot


var paused: bool = false
func set_paused(value: bool) -> void:
	paused = value
func is_paused() -> bool:
	return paused

@export var process_callback: TimerProcessCallback = TimerProcessCallback.PROCESS
func set_timer_process_callback(value: TimerProcessCallback) -> void:
	process_callback = value
func get_timer_process_callback() -> TimerProcessCallback:
	return process_callback

var time_left: float = -1.0:
	set(value):
		time_left = value
		if time_left <= 0:
			timeout.emit()
			if !one_shot: 
				time_left = wait_time
			else:
				_processing = false
				time_left = -1
func get_time_left() -> float:
	return time_left
