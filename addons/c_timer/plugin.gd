@tool
extends EditorPlugin

const TYPE = "CTimer"
const PARENT = "Node"
const _script = preload("res://addons/c_timer/plugin.gd")
const icon = preload("res://addons/c_timer/icon.png")

func _enter_tree() -> void:
	#add_custom_type(TYPE, PARENT, _script, icon)
	pass


func _exit_tree() -> void:
	#remove_custom_type(TYPE)
	pass
