extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	
func _process(delta: float) -> void:
	rotation += 6 * delta


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage()
