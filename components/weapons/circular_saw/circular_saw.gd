class_name CircularSaw
extends Node2D


@onready var _rotation_point: Marker2D = %RotationPoint
@onready var _timer: Timer = $Timer

var _saw_component = preload("res://components/weapons/saw/saw.tscn")


var _current_resource_index: int = 0:
	set(value):
		_current_resource_index = value
		_configure_current_resource()
var _current_resource: CircularSawResource
var _resources: Array[CircularSawResource] = [
	load("res://data/weapons/circular_saw/001_common_circular_saw.tres"),
	load("res://data/weapons/circular_saw/002_uncommon_circular_saw.tres"),
	load("res://data/weapons/circular_saw/003_rare_circular_saw.tres"),
	load("res://data/weapons/circular_saw/004_epic_circular_saw.tres"),
	load("res://data/weapons/circular_saw/005_legendary_circular_saw.tres"),
	load("res://data/weapons/circular_saw/006_mythic_circular_saw.tres"),
]

var state: bool = false;

#region Engine
func _ready() -> void:
	_configure_current_resource()

func _process(delta: float) -> void:
	rotation += 4 * delta
	pass
#endregion


#region Timer
func _configure_timer() -> void:
	if not _timer: return
	if _current_resource.is_special:
		_timer.timeout.disconnect(_on_timer_timeout)
		_timer.stop()
		return;
	
	_timer.wait_time = _current_resource.cooldown
	
	if _timer.is_stopped():
		_timer.start()
		_timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout() -> void:
	if state: _remove_all_saws()
	else: _draw_saws()
	state = !state
#endregion


func _configure_current_resource() -> void:
	_current_resource = _resources[_current_resource_index]
	_draw_saws()
	_configure_timer()


func upgrade() -> void:
	if _current_resource_index < _resources.size()-1:
		_current_resource_index += 1


func downgrade() -> void:
	if _current_resource_index > 0:
		_current_resource_index -= 1


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
