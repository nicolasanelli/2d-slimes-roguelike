extends Label

func _process(_delta: float) -> void:
	text = "Time elapsed: %s" % GameManager.run_stats.get_time_elapsed_as_string()
