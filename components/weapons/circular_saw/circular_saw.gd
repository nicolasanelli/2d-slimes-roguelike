class_name CircularSaw
extends Node2D


@onready var _rotation_point: Marker2D = %RotationPoint
@onready var _timer: CTimer = $CTimer

var _saw_component = preload("res://components/weapons/circular_saw/saw/saw.tscn")


var _current_resource: CircularSawResource:
	set(value):
		_current_resource = value
		_configure_current_resource()


var state: bool = false;

#region Engine
func _ready() -> void:
	_configure_current_resource()

func _process(delta: float) -> void:
	rotation += 4 * delta  * GlobalTimer.get_factor()
	pass
#endregion


#region Timer
func _configure_timer() -> void:
	if not _timer: return
	if _current_resource.is_special:
		AudioManager.play_saw()
		_timer.timeout.disconnect(_on_timer_timeout)
		_timer.stop()
		return;
	
	_timer.wait_time = _current_resource.cooldown
	
	if _timer.is_stopped():
		_timer.start()
		AudioManager.play_saw()
		_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	if state:
		AudioManager.stop_saw()
		_remove_all_saws()
	else: 
		_draw_saws()
		AudioManager.play_saw()
	state = !state
#endregion


func _configure_current_resource() -> void:
	if !_rotation_point: return
	_draw_saws()
	_configure_timer()


func upgrade(resouce: CircularSawResource) -> void:
	_current_resource = resouce


func _remove_all_saws() -> void:
	for n in _rotation_point.get_children():
		n.free()


func _draw_saws() -> void:
	_remove_all_saws()
	
	var quantity = _current_resource.quantity
	var radius = _current_resource.radius
	
	for n in quantity:
		var saw: Saw = _saw_component.instantiate()
		saw.position = Vector2(radius, 0).rotated((n * 2) * PI / quantity)
		saw.set_damage(_current_resource.damage)
		_rotation_point.add_child(saw)
