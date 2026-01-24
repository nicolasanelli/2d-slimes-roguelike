class_name XpOrb
extends CharacterBody2D

@onready var _animation_player: AnimationPlayer = $AnimationPlayer

var _target: Node2D
var _base_velocity := 550

const DEATH_RADIUS_OFFSET: int = 50

func _ready() -> void:
	_animation_player.play("idle")

func _physics_process(_delta: float) -> void:
	if (not _target): return
	
	if global_position.distance_to(_target.global_position) < DEATH_RADIUS_OFFSET: 
		_absorv()
	
	var direction = global_position.direction_to(_target.global_position)
	velocity = direction * _base_velocity
	move_and_slide()

func set_target(target: Node2D) -> void:
	_target = target

func _absorv() -> void:
	#AudioManager.play_pickup()
	# TODO Gambi temporária
	GameManager.player_rundata.experience_component.add_experience(1)
	queue_free()
