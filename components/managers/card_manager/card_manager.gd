class_name CardManager
extends Node2D


signal card_picked


@export var _player: Player
@onready var _canvas_layer: CanvasLayer = %CanvasLayer


var _highlighted_card: ActionCard


func _ready() -> void:
	assert(_player != null, "Player must be set in CardManager")


func _process(_delta: float) -> void:
	_canvas_layer.visible = visible


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click") and _highlighted_card:
		print_debug(_highlighted_card)
		_highlighted_card.activate(_player)
		card_picked.emit()
		_remove_all_cards()
		times +=1

var times = 0
func display_cards() -> void:
	visible = true
	if times == 0:
		if shown_cards == 0:
			_add_card()
		return
	
	if times < 6:
		while shown_cards < 3:
			_add_card2()
		return
	
	while shown_cards < 3:
		_add_card3()
		

var shown_cards = 0
func _add_card() -> void:
	var _scene = preload("res://components/cards/action_card/action_card.tscn")
	var card: Control = _scene.instantiate()
	card.my_mouse_entered.connect(_on_card_touched)
	card.my_mouse_exited.connect(_on_card_untouched)
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)
	shown_cards += 1


func _add_card2() -> void:
	var _scene = preload("res://components/cards/upgrade_card/upgrade_card.tscn")
	var card: Control = _scene.instantiate()
	card.my_mouse_entered.connect(_on_card_touched)
	card.my_mouse_exited.connect(_on_card_untouched)
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)
	shown_cards += 1


func _add_card3() -> void:
	var _scene = preload("res://components/cards/heal_card/heal_card.tscn")
	var card: Control = _scene.instantiate()
	card.my_mouse_entered.connect(_on_card_touched)
	card.my_mouse_exited.connect(_on_card_untouched)
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)
	shown_cards += 1


func _remove_all_cards() -> void:
	var children = $CanvasLayer/ColorRect/HBoxContainer.get_children()
	
	for n in range(children.size()):
		_remove_card(children[n])

func _remove_card(card: ActionCard) -> void:
	card.queue_free()
	_highlighted_card = null
	shown_cards -= 1


func _on_card_touched(card: ActionCard) -> void:
	card.highlight()
	_highlighted_card = card

func _on_card_untouched(card: ActionCard) -> void:
	card.unhighlight()
	_highlighted_card = null
