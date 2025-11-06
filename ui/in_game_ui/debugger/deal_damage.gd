extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	var player : Player = get_tree().get_first_node_in_group("Player")
	if not player: return
	
	player.health_component.damage(10)
