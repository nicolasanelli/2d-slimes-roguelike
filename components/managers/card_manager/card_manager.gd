class_name CardManager
extends Node2D


@export var _player: Player
@onready var _canvas_layer: CanvasLayer = %CanvasLayer


func _ready() -> void:
	assert(_player != null, "Player must be set in CardManager")
	CommandDispatcher.card_picked.connect(_on_card_picked)


func _process(_delta: float) -> void:
	_canvas_layer.visible = visible


func _on_card_picked(card: ActionCard) -> void:
	card.execute(_player)
	_remove_all_cards()
	visible = false
	CommandDispatcher.card_executed.emit()


func display_cards() -> void:
	visible = true
	_add_weapon_card()
	_add_weapon_card()
	_upgrade_weapon_card()


func _add_weapon_card() -> void:
	var card: Control = pick_weapon_card()
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)

func _upgrade_weapon_card() -> void:
	var card: Control = pick_upgrade_card()
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)


func pick_weapon_card() -> AddWeaponCard:
	var options = [
		"res://data/usable_card/add_weapon_cards/add_pistol_card.tres",
		"res://data/usable_card/add_weapon_cards/add_csaw_card.tres"
	]
	var chose = options.pick_random()
	var _scene = load("res://components/cards/add_weapon_card/add_weapon_card.tscn")
	var _card: AddWeaponCard = _scene.instantiate()
	_card._weapon_resource = load(chose)
	return _card


func pick_upgrade_card() -> UpgradeWeaponCard:
	var options = [
		"res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_uncommon.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_rare.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_epic.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_legendary.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_pistol_mythic.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_uncommon.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_rare.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_epic.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_legendary.tres",
		"res://data/usable_card/upgrade_weapon_cards/upgrade_csaw_mythic.tres",
	]
	var chose = options.pick_random()
	var _scene = load("res://components/cards/upgrade_weapon_card/upgrade_weapon_card.tscn")
	var _card: UpgradeWeaponCard = _scene.instantiate()
	_card._weapon_resource = load(chose)
	return _card


func _remove_all_cards() -> void:
	var children = $CanvasLayer/ColorRect/HBoxContainer.get_children()
	
	for n in range(children.size()):
		children[n].queue_free()
