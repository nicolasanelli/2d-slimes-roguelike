@icon("icon.png")
class_name CTimer
extends Node


signal timeout


@export var process_callback: TimerProcessCallback = TimerProcessCallback.IDLE
@export_range(0.001, 4096, 1, "suffix:s") var wait_time: float = 1
@export var one_shot: bool = false
@export var autostart: bool = false
#@export var time_scale: float = 1


func set_wait_time(value: float) -> void:
	wait_time = value
func get_wait_time() -> float:
	return wait_time


var _processing: bool = false


enum TimerProcessCallback {
	PHYSICS,
	IDLE
}


func _ready() -> void:
	if autostart: start()
	autostart = false


func _physics_process(delta: float) -> void:
	if process_callback == TimerProcessCallback.PHYSICS and _processing and !paused:
		time_left -= (delta * GlobalTimer.get_factor())

func _process(delta: float) -> void:
	if process_callback == TimerProcessCallback.IDLE and _processing and !paused:
		time_left -= (delta * GlobalTimer.get_factor())


func start(time_sec: float = -1) -> void:
	_processing = true
	if time_sec > 0:
		time_left = time_sec
		wait_time = time_sec
	else:
		time_left = wait_time


func stop() -> void:
	_processing = false
	time_left = 0
	
func is_stopped() -> bool:
	return !_processing



func set_autostart(value: bool) -> void:
	autostart = value
func has_autostsart() -> bool:
	return autostart



func set_one_shot(value: bool) -> void:
	one_shot = value
func is_one_shot() -> bool:
	return one_shot


var paused: bool = false
func set_paused(value: bool) -> void:
	paused = value
func is_paused() -> bool:
	return paused

func set_timer_process_callback(value: TimerProcessCallback) -> void:
	process_callback = value
func get_timer_process_callback() -> TimerProcessCallback:
	return process_callback

var time_left: float = -1.0:
	set(value):
		time_left = max(value, 0)
		if !is_stopped() and time_left == 0:
			timeout.emit()
			if !one_shot:
				time_left = wait_time
			else:
				_processing = false
				time_left = 0
func get_time_left() -> float:
	return time_left
