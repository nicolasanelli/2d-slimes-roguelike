extends Button

@export var amount = 100

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var player : Player = get_node_or_null("/root/GameScreen/Player")
	if not player: return
	
	if amount < 0:
		player._experience_component.add_experience(
			player._experience_component.get_missing_to_next()
		)
	else:
		player._experience_component.add_experience(amount)
