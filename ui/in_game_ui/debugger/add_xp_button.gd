extends Button

@export var amount = 100

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var player = $/root/GameScreen/Player
	if not player: return
	
	player._experience_component.add_experience(amount)
