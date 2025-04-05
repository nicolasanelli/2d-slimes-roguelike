extends Label

func _ready() -> void:
	visible = !Util.is_mobile()
