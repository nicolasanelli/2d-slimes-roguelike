class_name WeaponInventoryComponent
extends Node2D

var inventory: Dictionary[String, BaseWeapon] = {}

const GROUP_NAME = "Weapons";
const METADATA_TAG = "WeaponName"

func add(weapon: BaseWeapon) -> void:
	var weapon_name = weapon.get_name()
	
	if inventory.has(weapon_name):
		inventory[weapon_name].queue_free()
		inventory.erase(weapon_name)
	
	inventory[weapon_name] = weapon
	add_child(weapon, true)
	CommandDispatcher.inventory_updated.emit(inventory)
