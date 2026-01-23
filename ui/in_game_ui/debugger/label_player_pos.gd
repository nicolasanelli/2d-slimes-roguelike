extends Label

func _process(_delta: float) -> void:
	var player : Player = GameManager.player
	if not player: return
	
	text = "Pos(%.1f, %.1f)" % [player.global_position.x, player.global_position.y]
