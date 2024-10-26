extends CanvasLayer

@onready var _pause_button: Button = $MarginContainer2/PauseButton


func _ready() -> void:
	if not Global.is_mobile():
		visible = false
		var children = get_children()
		for child in children:
			child.free()
	else:
		visible = true
		_pause_button.pressed.connect(_on_pause_button_pressed)


func _on_pause_button_pressed() -> void:
	Debugger.instance.visible = !Debugger.instance.visible 
