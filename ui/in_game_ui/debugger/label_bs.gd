extends Label

func _process(_delta: float) -> void:
	text = "Bullets shooted: %s" % Statistics.get_bullet_shooted()
