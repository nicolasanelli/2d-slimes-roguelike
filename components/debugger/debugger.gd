class_name Debugger extends Control


#region Singleton
static var instance: Debugger

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@onready var _gun: Area2D = $/root/Game/Player/Weapons/Pistol
@onready var _saw: Node2D = $/root/Game/Player/Weapons/CircularSaw

@onready var _label: Label = $VBoxContainer/Label
@onready var _increase: Button = $VBoxContainer/HBoxContainer/Increase
@onready var _decrease: Button = $VBoxContainer/HBoxContainer/Decrease

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

@onready var _label_pp : Label = $VBoxContainer/LabelPlayerPos


func _ready() -> void:
	_increase.pressed.connect(_saw.upgrade)
	_decrease.pressed.connect(_saw.downgrade)
	_increase_as.pressed.connect(_gun.upgrade)
	_decrease_as.pressed.connect(_gun.downgrade)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("open_debug_panel"):
		visible = !visible
		

func _process(_delta: float) -> void:
	_label.text = "Sail level: %s" % _saw._current_resource.rarity
	_label_as.text = "Pistol level: %s" % _gun._current_resource.rarity
	_label_ms.text = "Monster spawned: %s" % _mob_spawned
	_label_mk.text = "Monster killed: %s" % _mob_killed
	_label_mc.text = "Monster count: %s" % (_mob_spawned - _mob_killed)
	_label_bs.text = "Bullets shooted: %s" % _bullets_shooted
	_label_pp.text = "Player (%.2f, %.2f)" % [Player.instance.global_position.x, Player.instance.global_position.y]


func increaseMobSpawned() -> void:
	_mob_spawned += 1


func increaseMobKilled() -> void:
	_mob_killed += 1


func increaseBulletsShooted() -> void:
	_bullets_shooted += 1
