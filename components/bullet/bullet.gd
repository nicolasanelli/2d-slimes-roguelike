extends Area2D


var _travelled_distance = 0


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
	
func _physics_process(delta: float) -> void:
	const SPEED = 1000
	const MAX_RANGE = 2300
	
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	_travelled_distance += SPEED * delta
	if _travelled_distance > MAX_RANGE:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
		
