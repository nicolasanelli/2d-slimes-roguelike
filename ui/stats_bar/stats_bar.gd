class_name StatsBar
extends Control


@export var _player: Player


@onready var _hbox: HBoxContainer = $HBoxContainer


var _stat_item_component = preload("res://ui/stat_item/stat_item.tscn")


func _ready() -> void:
	assert(_player != null, "Player is not set in StatsBar")
	_remove_all_stats()
	_player.find_child("WeaponInventoryComponent").inventory_changed.connect(_on_inventory_changed)


func _on_inventory_changed() -> void:
	var dict: Dictionary = _player.find_child("WeaponInventoryComponent").get_inventory()
	
	_remove_all_stats()
	var keys = dict.keys()
	for n in range(dict.size()):
		_add_item_stat(keys[n], dict.get(keys[n])._current_resource)


func _remove_all_stats() -> void:
	var list = _hbox.get_children()
	for n in range(list.size()):
		list[n].queue_free()


func _add_item_stat(_key: String, resource: BaseWeapon) -> void:
	var item: StatItem = _stat_item_component.instantiate()
	item._resource = resource
	_hbox.add_child(item)
