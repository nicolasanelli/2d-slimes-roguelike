extends Label

func _process(_delta: float) -> void:
	var player : Player = get_node_or_null("/root/GameScreen/Player")
	if not player: return
	
	text = "Total XP: %.0f" % player.find_child("ExperienceComponent").get_total_experience()
