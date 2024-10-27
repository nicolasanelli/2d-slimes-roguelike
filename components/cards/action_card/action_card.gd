class_name ActionCard
extends Control


signal my_mouse_entered(card: ActionCard)
signal my_mouse_exited(card: ActionCard)


@onready var _card: Card = $Card
@onready var _action: Node = $Action


func _ready() -> void:
	_card.mouse_entered.connect(_on_mouse_entered)
	_card.mouse_exited.connect(_on_mouse_exited)


func highlight() -> void:
	_card.highlight()

func unhighlight() -> void:
	_card.unhighlight()


func activate(_player: Player) -> void:
	_action.execute(_player)


func _on_mouse_entered(card: Card) -> void:
	my_mouse_entered.emit(self)


func _on_mouse_exited(card: Card) -> void:
	my_mouse_exited.emit(self)
