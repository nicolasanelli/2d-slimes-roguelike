extends Label

func _process(_delta: float) -> void:
	var player = $/root/GameScreen/Player
	if not player: return
	
	text = "Player Level: %s" % player.find_child("ExperienceComponent")._current_level
