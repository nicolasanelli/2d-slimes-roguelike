extends HBoxContainer


var _stat_item_component = preload("res://ui/stat_item/stat_item.tscn")


func _ready() -> void:
	_clear()
	CommandDispatcher.inventory_updated.connect(_on_inventory_updated)


func _clear() -> void:
	var list = get_children()
	for n in range(list.size()):
		list[n].queue_free()


func _on_inventory_updated(dict) -> void:
	_clear()
	var keys = dict.keys()
	for n in range(dict.size()):
		_add_item_stat(keys[n], dict.get(keys[n])._current_resource)


func _add_item_stat(_key: String, resource: BaseWeaponResource) -> void:
	var item: StatItem = _stat_item_component.instantiate()
	item._resource = resource
	add_child(item)
