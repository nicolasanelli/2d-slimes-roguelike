extends Label

func _process(_delta: float) -> void:
	text = "Monster killed: %s" % GameManager.run_stats.get_mob_killed()
