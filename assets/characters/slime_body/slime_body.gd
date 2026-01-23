class_name SlimeBody
extends Node2D


@onready var _animation_player: AnimationPlayer = %AnimationPlayer


func play_idle():
	if _animation_player.current_animation == "hurt":
		_animation_player.queue("idle")
	else:
		_animation_player.play("idle")


func play_walk():
	if _animation_player.current_animation == "hurt":
		_animation_player.queue("walk")
	else:
		_animation_player.play("walk")


func play_hurt():
	_animation_player.play("hurt")
