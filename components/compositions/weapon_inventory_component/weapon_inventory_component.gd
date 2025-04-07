class_name WeaponInventoryComponent
extends Node2D


var _inventory: Dictionary[String, BaseWeapon] = {}

const GROUP_NAME = "Weapons";
const METADATA_TAG = "WeaponName"


func add(scene: BaseWeapon) -> void:
	var weapon_name = scene.get_name()
	if _inventory.has(weapon_name):
		print_debug("Trying to add scene with WeaponName metadata='%s', but it is already in inventory", weapon_name)
		return
	
	_inventory[weapon_name] = scene
	add_child(scene)
	CommandDispatcher.inventory_updated.emit(_inventory)


func upgrade_by_name(weapon_name: String, resource: BaseWeaponData) -> void:
	if !_inventory.has(weapon_name):
		push_error("Trying to upgrade %s, but there is none inventory" % weapon_name)
		return
	
	_inventory[weapon_name].upgrade(resource)
	CommandDispatcher.inventory_updated.emit(_inventory)


func downgrade_by_name(weapon_name: String) -> void:
	if !_inventory.has(weapon_name):
		push_error("Trying to downgrade %s, but there is none inventory" % weapon_name)
		return
	
	_inventory[weapon_name].downgrade()
	CommandDispatcher.inventory_updated.emit(_inventory)


func has_weapon(weapon_name: String) -> bool:
	return _inventory.has(weapon_name)
