extends Label

func _process(_delta: float) -> void:
	text = "Timer: %.3f" % $Timer.time_left
