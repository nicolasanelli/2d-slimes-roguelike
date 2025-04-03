class_name Debugger
extends CanvasLayer


#region Singleton
static var instance: Debugger

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@export var _player: Player

@onready var _label_ms: Label = $Control/VBoxContainer/LabelMS
@onready var _label_mk: Label = $Control/VBoxContainer/LabelMK
@onready var _label_mc: Label = $Control/VBoxContainer/LabelMC
@onready var _label_bs: Label = $Control/VBoxContainer/LabelBS

@onready var _label_pp : Label = $Control/VBoxContainer/LabelPlayerPos
@onready var _label_xp : Label = $Control/VBoxContainer/LabelPlayersXP

@onready var _add_100_xp: Button = $Control/VBoxContainer/HBoxContainer/Add100XPButton
@onready var _add_1000_xp: Button = $Control/VBoxContainer/HBoxContainer/Add1000XPButton

@onready var _label_sf : Label = $Control/VBoxContainer/LabelSF

@onready var _increase_sf: Button = $Control/VBoxContainer/HBoxContainer3/Increase
@onready var _reset_sf: Button = $Control/VBoxContainer/HBoxContainer3/Reset
@onready var _decrease_sf: Button = $Control/VBoxContainer/HBoxContainer3/Decrease

@onready var _label_te : Label = $Control/VBoxContainer/LabelTE
@onready var _game_over: Button = $Control/VBoxContainer/GameOver

@onready var _timer : Timer = $Control/Timer
@onready var _label_timer : Label = $Control/VBoxContainer/Timer

@onready var _c_timer : Node = $Control/CustomTimer
@onready var _c_label_timer : Label = $Control/VBoxContainer/CTimer

var factor = 1;

func _ready() -> void:
	assert(_player != null, "Player is not set in Debugger")
	factor = GlobalTimer.get_factor()
	_increase_sf.pressed.connect(_on_increase_sf)
	_reset_sf.pressed.connect(_on_reset_sf)
	_decrease_sf.pressed.connect(_on_decrease_sf)
	_add_100_xp.pressed.connect(_on_add_100_xp)
	_add_1000_xp.pressed.connect(_on_add_1000_xp)
	_game_over.pressed.connect(_on_game_over)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_debug_panel"):
		visible = !visible


func _process(_delta: float) -> void:
	_label_ms.text = "Monster spawned: %s" % Statistics.get_spawned_mob()
	_label_mk.text = "Monster killed: %s" % Statistics.get_mob_killed()
	_label_mc.text = "Monster count: %s" % (Statistics.get_spawned_mob() - Statistics.get_mob_killed())
	_label_bs.text = "Bullets shooted: %s" % Statistics.get_bullet_shooted()
	_label_pp.text = "Player pos(%.2f, %.2f)" % [_player.global_position.x, _player.global_position.y]
	_label_xp.text = "Player Level: %s" % _player.find_child("ExperienceComponent")._current_level
	_label_timer.text = "Timer: %s" % _timer.time_left
	_c_label_timer.text = "CTimer: %s" % _c_timer.time_left
	_label_sf.text = "Speed factor: %.3f" % GlobalTimer.get_factor()
	_label_timer.visible = visible
	_c_label_timer.visible = visible
	_label_te.text = "Time elapsed: %s" % Statistics.get_time_elapsed_as_string()


func _on_increase_sf() -> void:
	factor += + 0.25
	GlobalTimer.set_target_factor(factor, 0.3)
func _on_reset_sf() -> void:
	factor = 1
	GlobalTimer.set_target_factor(1)
func _on_decrease_sf() -> void:
	factor -= + 0.25
	GlobalTimer.set_target_factor(factor, 0.3)

func _on_add_100_xp() -> void:
	_player._experience_component.add_experience(100)
func _on_add_1000_xp() -> void:
	_player._experience_component.add_experience(1000)
func _on_game_over() -> void:
	_player._health_component.damage(1000)
