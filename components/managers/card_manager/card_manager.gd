class_name CardManager
extends Node2D


@export var _player: Player
@onready var deck_manager: DeckManager = $DeckManager
@onready var _canvas_layer: CanvasLayer = %CanvasLayer

var displayed_cards: Array[DeckCard];

func _ready() -> void:
	assert(_player != null, "Player must be set in CardManager")
	CommandDispatcher.card_picked.connect(_on_card_picked)


func _process(_delta: float) -> void:
	_canvas_layer.visible = visible

func _on_card_picked(card: ActionCard) -> void:
	card.execute(_player)
	_remove_selected_card(card)
	_remove_all_cards()
	visible = false
	CommandDispatcher.card_executed.emit()


func display_cards() -> void:
	visible = true
	_add_cards()


func _add_cards() -> void:
	var cards = deck_manager.pick_cards()
	
	for card in cards:
		displayed_cards.push_front(card)
		$CanvasLayer/ColorRect/HBoxContainer.add_child(card.card)


func _remove_selected_card(card: ActionCard) -> void:
	var result = displayed_cards.filter(func(el): return el.card == card)
	displayed_cards.erase(result[0])
	#card.queue_free()

func _remove_all_cards() -> void:
	for n in displayed_cards:
		deck_manager.requeue(n)
	displayed_cards = []
		
	var children = $CanvasLayer/ColorRect/HBoxContainer.get_children()
	for n in range(children.size()):
		children[n].queue_free()
