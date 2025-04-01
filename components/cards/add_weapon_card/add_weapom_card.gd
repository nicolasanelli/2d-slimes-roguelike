class_name AddWeaponCard
extends ActionCard


@onready var _card: Card = $Card


var _weapon_resource: AddWeaponCardResource


func _ready() -> void:
	_card.pressed.connect(_on_card_pressed)


func _process(_delta: float) -> void:
	if _weapon_resource:
		_card._resource = _weapon_resource


func _on_card_pressed() -> void:
	CommandDispatcher.card_picked.emit(self)


func execute(_player: Player) -> void:
	var packed = load(_weapon_resource.weapon_component)
	var wic: WeaponInventoryComponent = _player.find_child("WeaponInventoryComponent")
	var weapon = packed.instantiate()
	
	if wic.has_weapon(weapon.get_meta("WeaponName")):
		weapon.queue_free()
		return
	
	weapon.position = _weapon_resource.position
	weapon._current_resource = _weapon_resource.resource
	wic.add(weapon)
