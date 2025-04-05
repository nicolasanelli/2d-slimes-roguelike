class_name StatItem
extends Panel


@onready var _margin_container: MarginContainer = %MarginContainer
@onready var _texture: TextureRect = %TextureRect
@onready var _level: Label = %Label


var _resource: BaseWeaponResource


func _process(_delta: float) -> void:
	_update_ui()


func _update_ui() -> void:
	if not _resource: return
	
	self_modulate = _resource.get_color()
	_margin_container.rotation_degrees = _resource.item_rotation_degree
	_texture.texture = _resource.texture
	_level.text = str(_resource.get_rarity())
