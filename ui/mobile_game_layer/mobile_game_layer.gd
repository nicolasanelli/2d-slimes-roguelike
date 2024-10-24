extends CanvasLayer


func _ready() -> void:
	if not Global.is_mobile():
		visible = false
		var children = get_children()
		for child in children:
			child.free()
