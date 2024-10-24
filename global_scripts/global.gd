extends Node


var current_scene = null
var force_mobile = false


func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)


func is_mobile() -> bool:
	if force_mobile: return true
	return OS.has_feature("web_android") or OS.has_feature("web_ios")


func reset_game():
	call_deferred("_deferred_goto_scene", "res://scenes/game/game.tscn")


func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
