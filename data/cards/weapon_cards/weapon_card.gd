class_name WeaponCard
extends CardData

@export var weapon: PackedScene
@export var resource: BaseWeaponData
# TODO: validate if it is really necessary, this could may be inside the weapon scene
@export var position: Vector2 = Vector2.ZERO

func get_background_color() -> Color:
	return resource.get_color()

func use(dict: Dictionary) -> void:
	var player: Player = dict.get("player")
	
	if !player: 
		push_error("dict.player is not defined in %s" % get_name())
		return
		
	var _weapon := weapon.instantiate()
	_weapon.position = position
	_weapon.set_resource(resource)
	
	# TODO still thinking about optimize optimize this, maybe Autoload PlayerManager
	var wic: WeaponInventoryComponent = player.find_child("WeaponInventoryComponent")
	wic.add(_weapon)
