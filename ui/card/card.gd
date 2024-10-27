@tool
class_name Card extends Node2D


signal mouse_entered(card: Card)
signal mouse_exited(card: Card)


@export var _resource: UsableCardResource


@onready var _panel_container: PanelContainer = %PanelContainer
@onready var _name: Label = %Name
@onready var _texture_rect: TextureRect = %TextureRect
@onready var _description: Label = %Description
@onready var _area: Area2D = %Area2D 


func _ready() -> void:
	_area.mouse_entered.connect(_on_mouse_entered)
	_area.mouse_exited.connect(_on_mouse_exited)


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


func _on_mouse_entered() -> void:
	mouse_entered.emit(self)

func _on_mouse_exited() -> void:
	mouse_exited.emit(self)
