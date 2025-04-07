class_name AddWeaponCard
extends ActionCard


@onready var _card: Card = $Card


var _resource: AddWeaponCardResource


func _ready() -> void:
	_card.pressed.connect(_on_card_pressed)


func _process(_delta: float) -> void:
	if _resource:
		_card._resource = _resource


func _on_card_pressed() -> void:
	CommandDispatcher.card_picked.emit(self)


func execute(_player: Player) -> void:
	var packed = load(_resource.weapon_component)
	var wic: WeaponInventoryComponent = _player.find_child("WeaponInventoryComponent")
	var weapon: BaseWeapon = packed.instantiate()
	
	if wic.has_weapon(weapon.get_name()):
		weapon.queue_free()
		return
	
	weapon.position = _resource.position
	weapon.set_resource(_resource.resource) 
	wic.add(weapon)
