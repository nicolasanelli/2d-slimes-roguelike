class_name CardData
extends Resource

@export var name: String
@export var texture: Texture2D
@export_multiline var description: String
@export var color: Color = Color.LIGHT_GRAY

func get_background_color() -> Color:
	return color

func use(_dict: Dictionary) -> void:
	pass
