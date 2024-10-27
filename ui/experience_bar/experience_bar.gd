class_name ExperienceBar
extends Control


@export var _player: Player

@onready var _progress_bar: ProgressBar = %ProgressBar
@onready var _label: Label = %Label


func _ready() -> void:
	assert(_player != null, "Player is not set in ExperienceBar")


func _process(_delta: float) -> void:
	#if !_player: return #TODO
	var actual = _player.find_children("ExperienceComponent")[0]._current_experience
	var target = _player.find_children("ExperienceComponent")[0]._target_experience
	
	_progress_bar.value = actual
	_progress_bar.max_value = target
	_label.text = "%d / %d" % [actual, target]
