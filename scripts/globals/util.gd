extends Node


var _force_mobile = false
var _auto_aim = false

func is_mobile() -> bool:
	if _force_mobile: return true
	return OS.has_feature("web_android") or OS.has_feature("web_ios")

func auto_aim() -> bool:
	return _auto_aim || is_mobile()
