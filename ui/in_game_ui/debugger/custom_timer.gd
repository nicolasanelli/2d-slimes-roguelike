extends Label

func _process(_delta: float) -> void:
	text = "CTimer: %.3f" % $CustomTimer.time_left
