class_name CircularSaw
extends Node2D


@onready var _rotation_point: Marker2D = %RotationPoint
@onready var _uptime_timer: CTimer = $UptimeTimer
@onready var _downtime_timer: CTimer = $DowntimeTimer

enum Status {
	UPTIME, DOWNTIME
}
var status : Status


var _saw_component = preload("res://components/weapons/circular_saw/saw/saw.tscn")

@export var _current_resource: CircularSawResource

var state: bool = false;

#region Engine
func _ready() -> void:
	_uptime_timer.timeout.connect(_play_downtime)
	_downtime_timer.timeout.connect(_play_uptime)
	_play_uptime()

func _process(delta: float) -> void:
	rotation += 4 * delta  * GlobalTimer.get_factor()
#endregion


func _play_uptime() ->void:
	_remove_all_saws()
	_draw_saws()
	AudioManager.play_saw()
	
	if _current_resource.is_special: return
	
	_uptime_timer.start(_current_resource.uptime)
	_downtime_timer.stop()
	
	
func _play_downtime() ->void:
	if _current_resource.is_special: return
	
	_remove_all_saws()
	AudioManager.stop_saw()
	
	_downtime_timer.start(_current_resource.downtime)


func upgrade(resouce: CircularSawResource) -> void:
	_current_resource = resouce
	_play_uptime()


func _remove_all_saws() -> void:
	for n in _rotation_point.get_children():
		n.free()

func _draw_saws() -> void:
	var quantity = _current_resource.quantity
	var radius = _current_resource.radius
	
	for n in quantity:
		var saw: Saw = _saw_component.instantiate()
		saw.position = Vector2(radius, 0).rotated((n * 2) * PI / quantity)
		saw.set_damage(_current_resource.damage)
		_rotation_point.add_child(saw)
