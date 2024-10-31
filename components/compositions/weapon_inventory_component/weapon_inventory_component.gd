class_name WeaponInventoryComponent
extends Node2D


signal inventory_changed


var _inventory = {}

const GROUP_NAME = "Weapons";
const METADATA_TAG = "WeaponName"


func add(scene: Node2D) -> void:
	if !scene.is_in_group(GROUP_NAME):
		push_error("Trying to add a non-weapon to WeaponInventory")
		return
	
	if !scene.has_meta(METADATA_TAG):
		push_error("Weapons should have a metadata 'WeaponName'. This should be unique for this weapon.")
		return
	
	var weapon_name = scene.get_meta(METADATA_TAG)
	if _inventory.has(weapon_name):
		print_debug("Trying to add scene with WeaponName metadata='%s', but it is already in inventory", weapon_name)
		return
	
	_inventory[weapon_name] = scene
	add_sibling(scene)
	inventory_changed.emit()


func upgrade_by_name(weapon_name: String) -> void:
	if !_inventory.has(weapon_name):
		push_error("Trying to upgrade %s, but there is none inventory" % weapon_name)
		return
	
	_inventory[weapon_name].upgrade()
	inventory_changed.emit()


func downgrade_by_name(weapon_name: String) -> void:
	if !_inventory.has(weapon_name):
		push_error("Trying to downgrade %s, but there is none inventory" % weapon_name)
		return
	
	_inventory[weapon_name].downgrade()
	inventory_changed.emit()


func has_weapon(weapon_name: String) -> bool:
	return _inventory.has(weapon_name)

func get_inventory():
	return _inventory
