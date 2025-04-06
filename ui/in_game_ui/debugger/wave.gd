extends Label

func _process(_delta: float) -> void:
	var manager = get_node_or_null("/root/GameScreen/EnemyManager")
	if not manager: return
	
	text = "Wave: %s" % manager._wave
