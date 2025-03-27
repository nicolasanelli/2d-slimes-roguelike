class_name CardManager
extends Node2D


signal card_picked


@export var _player: Player
@onready var _canvas_layer: CanvasLayer = %CanvasLayer


var _highlighted_card


func _ready() -> void:
	assert(_player != null, "Player must be set in CardManager")


func _process(_delta: float) -> void:
	_canvas_layer.visible = visible


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click") and _highlighted_card:
		_highlighted_card.activate()
		card_picked.emit()
		_remove_all_cards()
		times +=1
		visible = false

var times = 0
func display_cards() -> void:
	visible = true
	_add_weapon_card()
	_add_weapon_card()
	_add_weapon_card()


var shown_cards = 0
func _add_weapon_card() -> void:
	var card: Control = pick_weapon_card()
	card._player = _player
	card.my_mouse_entered.connect(_on_card_touched)
	card.my_mouse_exited.connect(_on_card_untouched)
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)
	shown_cards += 1

func pick_weapon_card() -> WeaponCard:
	var options = [
		"res://data/usable_card/weapon_card/pistol_card.tres",
		"res://data/usable_card/weapon_card/circular_saw_card.tres"
	]
	var chose = options.pick_random()
	var _scene = load("res://components/cards/weapon_card/weapon_card.tscn")
	var _card: WeaponCard = _scene.instantiate()
	_card._weapon_resource = load(chose)
	return _card


func _remove_all_cards() -> void:
	var children = $CanvasLayer/ColorRect/HBoxContainer.get_children()
	
	for n in range(children.size()):
		_remove_card(children[n])

func _remove_card(card) -> void:
	card.queue_free()
	_highlighted_card = null
	shown_cards -= 1

func _on_card_touched(card) -> void:
	card.highlight()
	_highlighted_card = card

func _on_card_untouched(card) -> void:
	card.unhighlight()
	_highlighted_card = null
