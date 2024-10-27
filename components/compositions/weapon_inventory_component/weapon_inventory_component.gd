class_name WeaponInventoryComponent
extends Node2D


var _inventory = {}


func add(_name: String, scene: Node2D) -> void:
	if _inventory.has(_name):
		push_error("Trying to add %s, but it is already in inventory" % _name)
		return
	
	_inventory[_name] = scene
	scene.name = _name
	add_child(scene, true)


func upgrade(_name: String) -> void:
	if !_inventory.has(_name):
		push_error("Trying to upgrade %s, but there is none inventory" % _name)
		return
	
	_inventory[_name].upgrade()


func downgrade(_name: String) -> void:
	if !_inventory.has(_name):
		push_error("Trying to downgrade %s, but there is none inventory" % _name)
		return
	
	_inventory[_name].downgrade()
