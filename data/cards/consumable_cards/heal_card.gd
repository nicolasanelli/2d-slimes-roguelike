class_name HealCard
extends CardData

@export var heal_amount: int

func use(dict: Dictionary) -> void:
	var player: Player = dict.get("player")
	
	if !player: 
		push_error("dict.player is not defined in %s" % get_name())
		return
		
	player._health_component.heal(heal_amount)
