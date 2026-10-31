extends CharacterBody2D
class_name Player

const MAX_SPEED = 200

@onready var happy_boo: HappyBoo = $HappyBoo

func _ready() -> void:
	happy_boo.play_walk_animation()


func _process(_delta: float) -> void:
	var movement_vector = get_movement_vector();
	var direction = movement_vector.normalized()
	
	velocity = direction * MAX_SPEED
	move_and_slide()


func get_movement_vector() -> Vector2:
	return Input.get_vector("move_left", "move_right", "move_up", "move_down");
