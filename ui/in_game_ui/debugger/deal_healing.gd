extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	var player_rundata : PlayerRundata =  GameManager.player_rundata
	
	player_rundata.health_component.heal(25)
