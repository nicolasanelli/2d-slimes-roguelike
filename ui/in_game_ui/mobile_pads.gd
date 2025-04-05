extends MarginContainer

func _ready() -> void:
	visible = Util.is_mobile()
