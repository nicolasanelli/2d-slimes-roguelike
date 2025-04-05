extends Node


signal player_leveled(level: int)
signal player_died


signal display_cards(cards: Array[ActionCard])
signal skip_cards
signal card_picked(card: ActionCard)
signal card_executed


# TODO add type
signal inventory_updated(dict)


signal game_paused
signal game_unpaused
