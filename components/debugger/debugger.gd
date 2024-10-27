class_name Debugger extends Control


#region Singleton
static var instance: Debugger

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@export var _player: Player

@onready var _saw: Node2D = $/root/Game/Player/Weapons/CircularSaw
@onready var _saw_info: Label = $VBoxContainer/SawInfo
@onready var _add_saw: Button = $VBoxContainer/AddSaw
@onready var _upgrade_saw: Button = $VBoxContainer/HBoxContainer1/UpgradeSaw
@onready var _downgrade_saw: Button = $VBoxContainer/HBoxContainer1/DowngradeSaw

@onready var _pistol: Node2D = $/root/Game/Player/Weapons/Pistol
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


func _ready() -> void:
	assert(_player != null, "Player is not set in Debugger")
	if _saw:
		_upgrade_saw.pressed.connect(_saw.upgrade)
		_downgrade_saw.pressed.connect(_saw.downgrade)
	_add_saw.pressed.connect(_on_add_saw)
	if _pistol:
		_upgrade_pistol.pressed.connect(_pistol.upgrade)
		_downgrade_pistol.pressed.connect(_pistol.downgrade)
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
	_label_xp.text = "Player XP: %s" % _player.find_children("ExperienceComponent")[0]._current_level


func _on_add_saw() -> void:
	var packed = load("res://components/weapons/circular_saw/circular_saw.tscn")
	var weapon = packed.instantiate()
	_player.add_weapon(weapon)

func _on_add_pistol() -> void:
	var packed = load("res://components/weapons/pistol/pistol.tscn")
	var weapon = packed.instantiate()
	_player.add_weapon(weapon)


func increaseMobSpawned() -> void:
	_mob_spawned += 1


func increaseMobKilled() -> void:
	_mob_killed += 1


func increaseBulletsShooted() -> void:
	_bullets_shooted += 1
