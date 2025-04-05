extends Label

func _process(_delta: float) -> void:
	text = "Monster spawned: %s" % Statistics.get_spawned_mob()
