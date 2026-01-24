extends Button

@export var amount = 100

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var player_rundata : PlayerRundata =  GameManager.player_rundata
	
	player_rundata.experience_component.add_experience(amount)
