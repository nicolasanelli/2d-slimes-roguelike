extends Button

func _ready() -> void:
	pressed.connect(_on_pressed)


func _on_pressed() -> void:
	var player : Player =  GameManager.player
	if not player: return
	
	print("Not Implemented 21")
