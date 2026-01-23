extends Button

@export var amount = 100

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	var player : Player =  GameManager.player
	if not player: return
	
	print("Not Implemented 20")
