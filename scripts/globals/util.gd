extends Node


var force_mobile = false


func is_mobile() -> bool:
	if force_mobile: return true
	return OS.has_feature("web_android") or OS.has_feature("web_ios")
