extends Node


func execute(_player: Player, _weapon_resource: WeaponCardResource) -> void:
	var packed = load(_weapon_resource.weapon_component)
	var weapon = packed.instantiate() 
	weapon.position = _weapon_resource.position
	
	var wic: WeaponInventoryComponent = _player.find_child("WeaponInventoryComponent")
	var weapon_name = weapon.get_meta("WeaponName");
	if wic.has_weapon(weapon_name):
		wic.upgrade_by_name(weapon_name)
	else:
		wic.add(weapon)
