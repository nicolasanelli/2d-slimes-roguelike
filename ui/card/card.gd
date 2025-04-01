class_name Card extends Button

@export var _resource: UsableCardResource


@onready var _panel_container: PanelContainer = %PanelContainer
@onready var _name: Label = %Name
@onready var _texture_rect: TextureRect = %TextureRect
@onready var _description: Label = %Description


func _ready() -> void:
	button_down.connect(highlight)
	button_up.connect(unhighlight)


func _process(_delta: float) -> void:
	assert(_resource != null, "Card has no resource")
	_panel_container.self_modulate = _resource.color
	_name.text = _resource.name
	_texture_rect.texture = _resource.texture
	_description.text = _resource.description


func highlight() -> void:
	modulate = Color(0.351, 0.351, 0.351)


func unhighlight() -> void:
	modulate = Color(1, 1, 1)
