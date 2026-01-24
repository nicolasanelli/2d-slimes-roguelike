class_name InGameUI
extends MarginContainer


@onready var fps: Label = %FPS
@onready var timer: Label = %Timer
@onready var hp_bar: ProgressBar = %HPBar
@onready var experience_bar: ProgressBar = %ExperienceBar


var rundata: PlayerRundata


func _ready() -> void:
	rundata = GameManager.player_rundata
	
	rundata.health_component.health_changed.connect(_health_changed)
	rundata.experience_component.experience_changed.connect(_experience_changed)
	
	experience_bar.value = 0
	experience_bar.max_value = 1
	
	hp_bar.value = 100
	hp_bar.max_value = 100


func _process(_delta: float) -> void:
	fps.text = "FPS: %.0f" % Engine.get_frames_per_second()
	timer.text = GameManager.run_stats.get_time_elapsed_as_string()


func _experience_changed(value: float, max_value: float, _total: float) -> void:
	experience_bar.value = value
	experience_bar.max_value = max_value


func _health_changed(value: float, max_value: float) -> void:
	hp_bar.value = value
	hp_bar.max_value = max_value
