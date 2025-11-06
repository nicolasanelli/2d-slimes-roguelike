extends Label

func _ready() -> void:
	CommandDispatcher.player_experience_changed.connect(_experience_changed)

func _experience_changed(component: ExperienceComponent) -> void:
	text = "Total XP: %.0f" % component.get_total_experience()
