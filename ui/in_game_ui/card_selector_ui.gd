extends MarginContainer


@onready var card_row: HBoxContainer = %CardRow
@onready var skip_button: Button = %SkipButton


func _ready() -> void:
	visible = false
	_clear_card_row()
	CommandDispatcher.display_cards.connect(_on_display_cards)
	CommandDispatcher.card_executed.connect(_on_card_executed)
	skip_button.pressed.connect(_on_skip_pressed)


func _on_display_cards(cards: Array[ActionCard]) -> void:
	for card in cards:
		card_row.add_child(card)
	visible = true


func _on_card_executed() -> void:
	_clear_card_row()
	visible = false


func _on_skip_pressed() -> void:
	CommandDispatcher.skip_cards.emit()
	AudioManager.play_click()


func _clear_card_row() -> void:
	var children = card_row.get_children()
	for n in range(children.size()):
		children[n].queue_free()
