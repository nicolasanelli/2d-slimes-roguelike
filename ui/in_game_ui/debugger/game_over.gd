extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	var player : Player = get_node_or_null("/root/GameScreen/Player")
	if not player: return
	
	player._health_component.damage(1000)
