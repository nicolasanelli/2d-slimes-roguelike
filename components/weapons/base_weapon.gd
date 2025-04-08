class_name BaseWeapon
extends Node2D

var resource: BaseWeaponData

func set_resource(base_weapon_data: BaseWeaponData) -> void:
	resource = base_weapon_data
	setup()

func get_resource() -> BaseWeaponData:
	return resource 

func setup():
	pass
