extends Node


func execute(_player: Player) -> void:
	var packed = load("res://components/weapons/pistol/pistol.tscn")
	var weapon: Pistol = packed.instantiate()
	weapon.position = Vector2(0, -33)
	_player.find_child("WeaponInventoryComponent").add("Pistol", weapon)
