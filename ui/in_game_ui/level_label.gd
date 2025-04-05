extends Label


func _ready() -> void:
	text = str(0)
	CommandDispatcher.player_leveled.connect(_on_player_leveled)


func _on_player_leveled(level: int) -> void:
	text = "%d" % level
