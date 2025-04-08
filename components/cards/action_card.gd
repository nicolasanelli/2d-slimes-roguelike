class_name ActionCard
extends Control

@export var resource: CardData
@onready var card: Card = $Card

func _ready() -> void:
	assert(resource != null, "ActionCard has no CardData resource defined!")
	card.update_visual(resource)
	card.pressed.connect(on_card_pressed)

func set_resource(_resource: CardData) -> void:
	resource = _resource

func on_card_pressed() -> void:
	CommandDispatcher.card_picked.emit(self)

func execute(player: Player) -> void:
	resource.use({
		"player": player
	})
