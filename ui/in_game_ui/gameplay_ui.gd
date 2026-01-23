extends MarginContainer


func _ready() -> void:
	CommandDispatcher.player_health_changed.connect(_health_changed)
	CommandDispatcher.player_experience_changed.connect(_experience_changed)
	%ExperienceBar.value = 0
	%ExperienceBar.max_value = 1
	%HPBar.value = 100
	%HPBar.max_value = 100


func _process(_delta: float) -> void:
	%FPS.text = "FPS: %.0f" % Engine.get_frames_per_second()
	%Timer.text = "%s" % GameManager.run_stats.get_time_elapsed_as_string()


func _experience_changed(component: ExperienceComponent) -> void:
	%ExperienceBar.value = component.get_current_experience()
	%ExperienceBar.max_value = component.get_target_experience()


func _health_changed(component: HealthComponent) -> void:
	%HPBar.value = component.get_current_health()
	%HPBar.max_value = component.get_max_health()
