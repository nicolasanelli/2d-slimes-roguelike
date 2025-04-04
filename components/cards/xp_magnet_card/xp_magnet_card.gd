class_name XpMagnetCard
extends ActionCard


@onready var _card: Card = $Card


var _resource: XpMagnetCardResource


func _ready() -> void:
	_card.pressed.connect(_on_card_pressed)


func _process(_delta: float) -> void:
	if _resource:
		_card._resource = _resource

func _on_card_pressed() -> void:
	CommandDispatcher.card_picked.emit(self)
	

func execute(_player: Player) -> void:
	var elements = DropManager.instance.get_children()
	for n in elements:
		if n.has_method("_absorv"):
			n.set_target(_player)
			n.set_base_velocity(1200)
	
