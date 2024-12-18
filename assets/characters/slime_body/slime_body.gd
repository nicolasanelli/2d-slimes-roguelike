@tool
class_name SlimeBody
extends Node2D


@onready var _animation_player: AnimationPlayer = %AnimationPlayer
@onready var _slime_body = %SlimeBody
@onready var _slime_body_hurt = %SlimeBodyHurt


func play_idle():
	if _animation_player.current_animation == "hurt": return
	_animation_player.play("idle")


func play_walk():
	if _animation_player.current_animation == "hurt": return
	_animation_player.play("walk")


func play_hurt():
	_animation_player.play("hurt")
	_animation_player.queue("walk")


func set_appearance(color: Color, 
				 hurt_color: Color,
				 _scale: Vector2) -> void:
	_slime_body.self_modulate = color
	_slime_body_hurt.self_modulate = hurt_color
	scale = _scale


func _physics_process(_delta: float) -> void:
	if Engine.is_editor_hint(): return
	_animation_player.speed_scale = GlobalTimer.get_factor()
