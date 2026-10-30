extends Button

@export var amount = 100

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var player_run_data : PlayerRundata =  GameManager.player_run_data
	
	player_run_data.experience_component.add_experience(amount)
