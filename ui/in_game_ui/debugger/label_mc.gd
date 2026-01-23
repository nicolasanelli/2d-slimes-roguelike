extends Label

func _process(_delta: float) -> void:
	text = "Monster count: %s" % (GameManager.run_stats.get_spawned_mob() - GameManager.run_stats.get_mob_killed())
