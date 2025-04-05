extends Label

func _process(_delta: float) -> void:
	text = "Monster count: %s" % (Statistics.get_spawned_mob() - Statistics.get_mob_killed())
