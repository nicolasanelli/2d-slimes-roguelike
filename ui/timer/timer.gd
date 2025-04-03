extends Label

func _process(_delta: float) -> void:
	text = "%s" % Statistics.get_time_elapsed_as_string()
