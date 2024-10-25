class_name BulletSpecial extends Area2D


var _damage = 1
var _speed = 1000
var _max_range = 1080

var _travelled_distance = 0


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func set_damage(value: int) -> void:
	_damage = value

	
func set_max_range(value: int) -> void:
	_max_range = value
	

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * _speed * delta
	
	_travelled_distance += _speed * delta
	if _travelled_distance > _max_range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		queue_free()
		body.take_damage(_damage)
	
	rotation += (PI * randf())
		
