class_name Card extends Button

@export var _resource: UsableCardResource


@onready var _panel_container: PanelContainer = %CardPanelContainer
@onready var _title: Label = %CardTitleLabel
@onready var _sprite: TextureRect = %Sprite
@onready var _description: Label = %CardDescriptionLabel


func _ready() -> void:
	button_down.connect(highlight)
	button_up.connect(unhighlight)


func _process(_delta: float) -> void:
	assert(_resource != null, "Card has no resource")
	_panel_container.self_modulate = _resource.color
	_title.text = _resource.name
	_sprite.texture = _resource.texture
	_description.text = _resource.description


func highlight() -> void:
	modulate = Color(0.351, 0.351, 0.351)


func unhighlight() -> void:
	modulate = Color(1, 1, 1)
