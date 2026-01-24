extends Label

func _ready() -> void:
	GameManager.player_rundata.experience_component.experience_changed.connect(_on_experience_changed)

func _on_experience_changed(_current: float, _target: float, total: float) -> void:
	text = "Total XP: %.0f" % total
