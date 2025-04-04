class_name XpOrb
extends CharacterBody2D


signal xp_absorved(instance_id: int, value: float)


@onready var _animation_player: AnimationPlayer = $AnimationPlayer


@export var _experience_value: int = 1;
var _target: Node2D
var _absobed: bool = false
var _base_velocity := 550

const DEATH_RADIUS_OFFSET: int = 50


func _ready() -> void:
	_animation_player.play("idle")


func _process(_delta: float) -> void:
	_animation_player.speed_scale = GlobalTimer.get_factor()

func _physics_process(_delta: float) -> void:
	if (not _target) or _absobed: return
	if global_position.distance_to(_target.global_position) < DEATH_RADIUS_OFFSET: _absorv()
	
	var direction = global_position.direction_to(_target.global_position)
	velocity = direction * _base_velocity * GlobalTimer.get_factor()
	move_and_slide()


func set_experience_value(value: int) -> void:
	_experience_value = value
	if (_experience_value > 20):
		$Sprite2D.modulate = Color(0.044, 0.0, 1.0)


func set_target(target: Node2D) -> void:
	_target = target


func set_base_velocity(base_velocity: int) -> void:
	_base_velocity = base_velocity


func is_already_absorbed() -> bool:
	return _absobed


func _absorv() -> void:
	_absobed = true
	xp_absorved.emit(get_instance_id(), _experience_value)
	AudioManager.play_pickup()
	queue_free()
