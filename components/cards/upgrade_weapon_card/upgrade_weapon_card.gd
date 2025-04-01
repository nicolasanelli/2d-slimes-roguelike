class_name UpgradeWeaponCard
extends ActionCard


@onready var _card: Card = $Card


var _weapon_resource: UpgradeWeaponCardResource


func _ready() -> void:
	_card.pressed.connect(_on_card_pressed)


func _process(_delta: float) -> void:
	if _weapon_resource:
		_card._resource = _weapon_resource


func _on_card_pressed() -> void:
	CommandDispatcher.card_picked.emit(self)


func execute(_player: Player) -> void:
	var wic: WeaponInventoryComponent = _player.find_child("WeaponInventoryComponent")
	
	if !wic.has_weapon(_weapon_resource.weapon_name):
		return
	
	wic.upgrade_by_name(
		_weapon_resource.weapon_name,
		_weapon_resource.resource
	)
