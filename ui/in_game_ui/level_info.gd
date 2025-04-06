extends Label


func _ready() -> void:
	CommandDispatcher.level_info_updated.connect(_on_level_info_updated)


func _on_level_info_updated(info: String) -> void:
	text = info
