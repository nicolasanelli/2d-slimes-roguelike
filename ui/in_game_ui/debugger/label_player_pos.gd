extends Label

func _process(_delta: float) -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	if not player: return
	
	text = "Pos(%.1f, %.1f)" % [player.global_position.x, player.global_position.y]
