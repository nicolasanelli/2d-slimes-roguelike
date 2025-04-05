class_name CardManager
extends Node2D


@export var _player: Player
@onready var deck_manager: DeckManager = $DeckManager


var displayed_cards: Array[DeckCard];

func _ready() -> void:
	assert(_player != null, "Player must be set in CardManager")
	CommandDispatcher.card_picked.connect(_on_card_picked)
	CommandDispatcher.skip_cards.connect(_on_skip_cards)


func _on_skip_cards() -> void:
	_requeue_remaining_cards()
	CommandDispatcher.card_executed.emit()
	

func _on_card_picked(card: ActionCard) -> void:
	card.execute(_player)
	_remove_selected_card(card)
	_requeue_remaining_cards()
	CommandDispatcher.card_executed.emit()


func display_cards() -> void:
	var deck_cards := deck_manager.pick_cards(2)
	
	var action_cards: Array[ActionCard] = []
	action_cards.assign(
		deck_cards.map(func (dc: DeckCard): return dc.card)
	)
	
	displayed_cards = deck_cards
	CommandDispatcher.display_cards.emit(action_cards)


func _remove_selected_card(card: ActionCard) -> void:
	var result = displayed_cards.filter(func(el): return el.card == card)
	displayed_cards.erase(result[0])

func _requeue_remaining_cards() -> void:
	for n in displayed_cards:
		deck_manager.requeue(n)
	displayed_cards = []
