extends Label

func _ready() -> void:
	CommandDispatcher.player_leveled.connect(_player_leveled)

func _player_leveled(component: ExperienceComponent) -> void:
	text = "Player LvL: %s" % component.get_current_level()
