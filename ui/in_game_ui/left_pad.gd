extends Control

func _ready() -> void:
	visible = Util.is_mobile()
