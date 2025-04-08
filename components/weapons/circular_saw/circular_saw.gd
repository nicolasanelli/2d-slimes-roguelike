class_name CircularSaw
extends BaseWeapon

const _saw_component = preload("res://components/weapons/circular_saw/saw/saw.tscn")

@onready var _rotation_point: Marker2D = %RotationPoint
@onready var _uptime_timer: CTimer = $UptimeTimer
@onready var _downtime_timer: CTimer = $DowntimeTimer

enum Status {
	UPTIME, DOWNTIME
}
var status : Status
var state: bool = false;

#region Engine
func _ready() -> void:
	_uptime_timer.timeout.connect(play_downtime)
	_downtime_timer.timeout.connect(play_uptime)
	play_uptime()

func _process(delta: float) -> void:
	rotation += 4 * delta  * GlobalTimer.get_factor()
#endregion

#region Override
func setup() -> void:
	if is_node_ready():
		play_uptime()

func get_resource() -> CircularSawResource:
	return super.get_resource()
#endregion

func play_uptime() ->void:
	_remove_all_saws()
	_draw_saws()
	AudioManager.play_saw()
	
	if get_resource().is_special: return
	
	_uptime_timer.start(get_resource().uptime)
	_downtime_timer.stop()
func play_downtime() ->void:
	if get_resource().is_special: return
	
	_remove_all_saws()
	AudioManager.stop_saw()
	
	_downtime_timer.start(get_resource().downtime)

func _remove_all_saws() -> void:
	for n in _rotation_point.get_children():
		n.free()
func _draw_saws() -> void:
	var quantity = get_resource().quantity
	var radius = get_resource().radius
	
	for n in quantity:
		var saw: Saw = _saw_component.instantiate()
		saw.position = Vector2(radius, 0).rotated((n * 2) * PI / quantity)
		saw.set_damage(get_resource().damage)
		_rotation_point.add_child(saw)
