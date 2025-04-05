extends Label

func _process(_delta: float) -> void:
	text = "Monster killed: %s" % Statistics.get_mob_killed()
