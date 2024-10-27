extends Node


func execute(_player: Player) -> void:
	_player.find_child("WeaponInventoryComponent").upgrade("Pistol")
