class_name HappyBoo extends Node2D


@onready var _animation_player = %AnimationPlayer


func play_idle_animation():
	_animation_player.play("idle")


func play_walk_animation():
	_animation_player.play("walk")
