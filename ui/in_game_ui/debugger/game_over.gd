extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	var player = $/root/GameScreen/Player
	if not player: return
	
	player._health_component.damage(1000)
