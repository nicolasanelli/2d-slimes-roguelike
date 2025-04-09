class_name SwordSlash
extends Node2D

@onready var _animation_player: AnimationPlayer = $AnimationPlayer
@onready var _collision_shape: CollisionShape2D = $Area2D/CollisionShape2D
@onready var _area_2d: Area2D = $Area2D

var _damage = 1
var _attack_range = 100.0

func _ready() -> void:
	_animation_player.play("slash")
	_collision_shape.shape.size.x = _attack_range
	
	# Connect body_entered signal in code
	_area_2d.body_entered.connect(_on_area_2d_body_entered)
	
	await _animation_player.animation_finished
	queue_free()

func set_damage(value: int) -> void:
	_damage = value

func set_range(value: float) -> void:
	_attack_range = value

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(_damage)
		# Statistics.add_damage_done(_damage) 
