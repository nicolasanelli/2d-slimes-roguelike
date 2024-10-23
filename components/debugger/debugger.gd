class_name Debugger extends Node2D


#region Singleton
static var instance: Debugger

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@onready var _gun: Area2D = $/root/Game/Player/Gun
@onready var _sail_gun: Node2D = $/root/Game/Player/SailGun

@onready var _label: Label = $VBoxContainer/Label
@onready var _increase: Button = $VBoxContainer/HBoxContainer/Increase
@onready var _decrease: Button = $VBoxContainer/HBoxContainer/Decrease

@onready var _label_r: Label = $VBoxContainer/LabelR
@onready var _increase_r: Button = $VBoxContainer/HBoxContainerR/IncreaseR
@onready var _decrease_r: Button = $VBoxContainer/HBoxContainerR/DecreaseR

@onready var _label_as: Label = $VBoxContainer/LabelAS
@onready var _increase_as: Button = $VBoxContainer/HBoxContainerAS/IncreaseAS
@onready var _decrease_as: Button = $VBoxContainer/HBoxContainerAS/DecreaseAS

@onready var _label_ms: Label = $VBoxContainer/LabelMS
var _mob_spawned: int = 0
@onready var _label_mk: Label = $VBoxContainer/LabelMK
var _mob_killed: int = 0
@onready var _label_mc: Label = $VBoxContainer/LabelMC
@onready var _label_bs: Label = $VBoxContainer/LabelBS
var _bullets_shooted: int = 0


func _ready() -> void:
	_increase.pressed.connect(_sail_gun.increase_quantity)
	_decrease.pressed.connect(_sail_gun.decrease_quantity)
	_increase_r.pressed.connect(_sail_gun.increase_radius)
	_decrease_r.pressed.connect(_sail_gun.decrease_radius)
	_increase_as.pressed.connect(_gun.increase_attack_speed)
	_decrease_as.pressed.connect(_gun.decrease_attack_speed)


func _process(_delta: float) -> void:
	_label.text = "Sail quantity: %s" % _sail_gun.get_quantity()
	_label_r.text = "Radius: %spx" % _sail_gun.get_radius()
	_label_as.text = "Attack Speed: %s" % _gun.get_attack_speed()
	_label_ms.text = "Monster spawned: %s" % _mob_spawned
	_label_mk.text = "Monster killed: %s" % _mob_killed
	_label_mc.text = "Monster count: %s" % (_mob_spawned - _mob_killed)
	_label_bs.text = "Bullets shooted: %s" % _bullets_shooted

func increaseMobSpawned() -> void:
	_mob_spawned += 1

func increaseMobKilled() -> void:
	_mob_killed += 1

func increaseBulletsShooted() -> void:
	_bullets_shooted += 1
