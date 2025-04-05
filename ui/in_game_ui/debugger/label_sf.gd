extends Label

func _process(_delta: float) -> void:
	text = "Speed factor: %.3f" % GlobalTimer.get_factor()
