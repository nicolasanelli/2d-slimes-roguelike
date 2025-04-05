extends Label

func _process(_delta: float) -> void:
	var player = $/root/GameScreen/Player
	if not player: return
	
	text = "Player pos(%.1f, %.1f)" % [player.global_position.x, player.global_position.y]
