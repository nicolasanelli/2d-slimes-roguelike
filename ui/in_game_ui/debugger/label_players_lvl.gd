extends Label

func _ready() -> void:
	GameManager.player_rundata.experience_component.leveled_up.connect(_on_player_leveled)

func _on_player_leveled(new_level: int) -> void:
	text = "Player LvL: %d" % new_level
