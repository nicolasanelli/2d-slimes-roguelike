extends Label

func _process(_delta: float) -> void:
	text = "Monster spawned: %s" % GameManager.run_stats.get_spawned_mob()
