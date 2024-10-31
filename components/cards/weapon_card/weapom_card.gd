@tool
class_name WeaponCard
extends Control


signal my_mouse_entered(card: WeaponCard)
signal my_mouse_exited(card: WeaponCard)


@onready var _card: Card = $Card
@onready var _action: Node = $Action


var _weapon_resource: WeaponCardResource


var _player: Player


func _ready() -> void:
	_card.mouse_entered.connect(_on_mouse_entered)
	_card.mouse_exited.connect(_on_mouse_exited)


func _process(delta: float) -> void:
	if _weapon_resource:
		_card._resource = _weapon_resource


func highlight() -> void:
	_card.highlight()

func unhighlight() -> void:
	_card.unhighlight()


func set_player(_player: Player) -> void:
	self._player = _player


func activate() -> void:
	assert(_player != null, "Player is not set in ActionCard")
	_action.execute(_player, _weapon_resource)


func _on_mouse_entered(__card: Card) -> void:
	my_mouse_entered.emit(self)


func _on_mouse_exited(__card: Card) -> void:
	my_mouse_exited.emit(self)
