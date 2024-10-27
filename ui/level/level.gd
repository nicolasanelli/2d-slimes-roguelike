class_name Level
extends Control


@export var _player: Player

@onready var _label: Label = %Label


func _ready() -> void:
	assert(_player != null, "Player is not set in Level")


func _process(_delta: float) -> void:
	var level = _player.find_child("ExperienceComponent")._current_level
	_label.text = "%d" % level
