extends Node


signal player_leveled(level: int)
signal player_died


signal display_cards(cards: Array[ActionCard])
signal skip_cards
signal card_picked(card: ActionCard)
signal card_executed


signal inventory_updated(inventary: Dictionary[String, Node2D])


signal game_paused
signal game_unpaused

signal level_info_updated(info: String)

signal victory
