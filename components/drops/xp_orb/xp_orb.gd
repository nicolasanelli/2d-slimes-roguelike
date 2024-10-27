class_name XpOrb
extends CharacterBody2D


signal xp_absorved(instance_id: int, value: float)


@onready var _animation_player: AnimationPlayer = $AnimationPlayer


var _experience_value: int = 1;
var _target_position: Vector2
var _absobed: bool = false

const DEATH_RADIUS_OFFSET: int = 50






func _ready() -> void:
	_animation_player.play("idle")


func _physics_process(_delta: float) -> void:
	if (not _target_position) or _absobed: return
	if global_position.distance_to(_target_position) < DEATH_RADIUS_OFFSET: _absorv()
	
	var direction = global_position.direction_to(_target_position)
	velocity = direction * 550
	move_and_slide()


func set_experience_value(value: int) -> void:
	_experience_value = value


func set_target_global_position(target: Vector2) -> void:
	_target_position = target


func is_already_absorbed() -> bool:
	return _absobed


func _absorv() -> void:
	_absobed = true
	xp_absorved.emit(get_instance_id(), _experience_value)
	queue_free()
