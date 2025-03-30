extends CanvasLayer

func _ready() -> void:
	if not Util.is_mobile():
		visible = false
		var children = get_children()
		for child in children:
			child.free()
	else:
		visible = true
