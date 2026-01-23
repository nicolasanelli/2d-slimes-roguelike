extends Label

func _process(_delta: float) -> void:
	text = "Bullets shooted: %s" % GameManager.run_stats.get_bullet_shooted()
