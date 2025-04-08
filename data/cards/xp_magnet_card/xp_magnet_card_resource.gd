class_name XpMagnetCardResource
extends CardData

func use(dict: Dictionary) -> void:
	var player: Player = dict.get("player")
	
	if !player: 
		push_error("dict.player is not defined in %s" % get_name())
		return
		
	var elements = DropManager.instance.get_children()
	for n in elements:
		if n.has_method("_absorv"):
			n.set_target(player)
			n.set_base_velocity(1200)
