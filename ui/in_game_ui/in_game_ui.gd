class_name InGameUI
extends CanvasLayer

@onready var mobile_pads: MarginContainer = $MobilePads

func _ready() -> void:
	mobile_pads.visible = Util.is_mobile()
