class_name Debugger extends Control


#region Singleton
static var instance: Debugger

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@export var _player: Player

var _saw: Node2D
@onready var _saw_info: Label = $VBoxContainer/SawInfo
@onready var _add_saw: Button = $VBoxContainer/AddSaw
@onready var _upgrade_saw: Button = $VBoxContainer/HBoxContainer1/UpgradeSaw
@onready var _downgrade_saw: Button = $VBoxContainer/HBoxContainer1/DowngradeSaw

var _pistol: Node2D
@onready var _pistol_info: Label = $VBoxContainer/PistolInfo
@onready var _add_pistol: Button = $VBoxContainer/AddPistol
@onready var _upgrade_pistol: Button = $VBoxContainer/HBoxContainer2/UpgradePistol
@onready var _downgrade_pistol: Button = $VBoxContainer/HBoxContainer2/DowngradePistol

@onready var _label_ms: Label = $VBoxContainer/LabelMS
var _mob_spawned: int = 0
@onready var _label_mk: Label = $VBoxContainer/LabelMK
var _mob_killed: int = 0
@onready var _label_mc: Label = $VBoxContainer/LabelMC
@onready var _label_bs: Label = $VBoxContainer/LabelBS
var _bullets_shooted: int = 0

@onready var _label_pp : Label = $VBoxContainer/LabelPlayerPos
@onready var _label_xp : Label = $VBoxContainer/LabelPlayersXP

@onready var _timer : Timer = $Timer
@onready var _label_timer : Label = $Timer/Label

@onready var _c_timer : Node = $CustomTimer
@onready var _c_label_timer : Label = $CustomTimer/Label

func _ready() -> void:
	assert(_player != null, "Player is not set in Debugger")
	_upgrade_saw.pressed.connect(_saw_upgrade)
	_downgrade_saw.pressed.connect(_saw_downgrade)
	_add_saw.pressed.connect(_on_add_saw)
	_upgrade_pistol.pressed.connect(_pistol_upgrade)
	_downgrade_pistol.pressed.connect(_pistol_downgrade)
	_add_pistol.pressed.connect(_on_add_pistol)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_debug_panel"):
		visible = !visible


func _process(_delta: float) -> void:
	#if !_player: return #TODO
	
	if _saw:
		_saw_info.text = "Sail level: %s" % _saw._current_resource.rarity
	if _pistol:
		_pistol_info.text = "Pistol level: %s" % _pistol._current_resource.rarity
	_label_ms.text = "Monster spawned: %s" % _mob_spawned
	_label_mk.text = "Monster killed: %s" % _mob_killed
	_label_mc.text = "Monster count: %s" % (_mob_spawned - _mob_killed)
	_label_bs.text = "Bullets shooted: %s" % _bullets_shooted
	_label_pp.text = "Player pos(%.2f, %.2f)" % [_player.global_position.x, _player.global_position.y]
	_label_xp.text = "Player XP: %s" % _player.find_child("ExperienceComponent")._current_level
	_label_timer.text = "Timer: %s" % _timer.time_left
	_c_label_timer.text = "CTimer: %s" % _c_timer.time_left

func _on_add_saw() -> void:
	var packed = load("res://components/weapons/circular_saw/circular_saw.tscn")
	var weapon: CircularSaw = packed.instantiate()
	if !_saw: _saw = weapon
	_player.find_child("WeaponInventoryComponent").add("Saw", weapon)

func _saw_upgrade() -> void:
	_player.find_child("WeaponInventoryComponent").upgrade("Saw")
	
func _saw_downgrade() -> void:
	_player.find_child("WeaponInventoryComponent").downgrade("Saw")

func _on_add_pistol() -> void:
	var packed = load("res://components/weapons/pistol/pistol.tscn")
	var weapon: Pistol = packed.instantiate()
	if !_pistol: _pistol = weapon
	weapon.position = Vector2(0, -33)
	_player.find_child("WeaponInventoryComponent").add("Pistol", weapon)

func _pistol_upgrade() -> void:
	_player.find_child("WeaponInventoryComponent").upgrade("Pistol")
	
func _pistol_downgrade() -> void:
	_player.find_child("WeaponInventoryComponent").downgrade("Pistol")
	

func increaseMobSpawned() -> void:
	_mob_spawned += 1


func increaseMobKilled() -> void:
	_mob_killed += 1


func increaseBulletsShooted() -> void:
	_bullets_shooted += 1
