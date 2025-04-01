class_name DoNothingCard
extends ActionCard


@onready var _card: Card = $Card


var _resource: UsableCardResource


func _ready() -> void:
	_card.pressed.connect(_on_card_pressed)


func _process(_delta: float) -> void:
	if _resource:
		_card._resource = _resource


func _on_card_pressed() -> void:
	CommandDispatcher.card_picked.emit(self)
	

func execute(_player: Player) -> void:
	pass
