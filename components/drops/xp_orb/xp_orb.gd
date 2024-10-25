class_name XpOrb
extends CharacterBody2D


var _experience_value: int = 1;
var _target_position: Vector2


const DEATH_RADIUS_OFFSET: int = 50


@onready var _animation_player: AnimationPlayer = $AnimationPlayer


signal xp_absorved(value: float)


func _ready() -> void:
	_animation_player.play("idle")


func _physics_process(_delta: float) -> void:
	if not _target_position: return
	if global_position.distance_to(_target_position) < DEATH_RADIUS_OFFSET: _absorv()
	
	var direction = global_position.direction_to(_target_position)
	velocity = direction * 550
	move_and_slide()


func set_experience_value(value: int) -> void:
	_experience_value = value


func set_target_global_position(target: Vector2) -> void:
	_target_position = target


func _absorv() -> void:
	xp_absorved.emit(_experience_value)
	queue_free()
