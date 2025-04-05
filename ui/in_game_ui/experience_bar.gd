extends ProgressBar


@onready var _experience_label: Label = $ExperienceLabel


func _process(_delta: float) -> void:
	# TODO search for a better/reliable way to do this
	var player = $/root/GameScreen/Player
	if not player: return
	
	var actual = player.find_child("ExperienceComponent")._current_experience
	var target = player.find_child("ExperienceComponent")._target_experience
	
	value = actual
	max_value = target
	_experience_label.text = "%d / %d" % [actual, target]
