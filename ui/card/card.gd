class_name Card 
extends Button

@export var resource: CardData
@onready var card_panel_container: PanelContainer = %CardPanelContainer
@onready var nameplate: Label = %NamePlate
@onready var texture: TextureRect = %Texture
@onready var description: Label = %Description

func _ready() -> void:
	connect_signals()
	update_visual(resource)

func connect_signals() -> void:
	button_down.connect(highlight)
	button_up.connect(unhighlight)
	pressed.connect(sfx)

func update_visual(_resource: CardData) -> void:
	if !_resource: return;
	nameplate.text = _resource.name
	texture.texture = _resource.texture
	description.text = _resource.description
	card_panel_container.self_modulate = _resource.get_background_color()

func sfx() -> void:
	AudioManager.play_click()

func highlight() -> void:
	modulate = Color(0.351, 0.351, 0.351)

func unhighlight() -> void:
	modulate = Color(1, 1, 1)
