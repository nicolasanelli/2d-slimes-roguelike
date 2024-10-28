class_name SlimeBody
extends Node2D


@onready var _animation_player = %AnimationPlayer
@onready var _slime_body = %SlimeBody
@onready var _slime_body_hurt = %SlimeBodyHurt


func play_idle():
	_animation_player.play("idle")


func play_walk():
	_animation_player.play("walk")


func play_hurt():
	_animation_player.play("hurt")
	_animation_player.queue("walk")


func set_visuals(color: Color, 
				 hurt_color: Color,
				 _scale: Vector2) -> void:
	_slime_body.self_modulate = color
	_slime_body_hurt.self_modulate = hurt_color
	scale = _scale


func _physics_process(_delta: float) -> void:
	_animation_player.speed_scale = GlobalTimer.get_factor()
