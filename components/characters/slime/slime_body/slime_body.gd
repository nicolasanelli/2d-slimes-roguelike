class_name SlimeBody
extends Node2D


@onready var _animation_player = %AnimationPlayer


func play_walk():
	_animation_player.play("walk")


func play_hurt():
	_animation_player.play("hurt")
	_animation_player.queue("walk")


func set_colors(body: Color) -> void:
	%SlimeBody.self_modulate = body


func _physics_process(_delta: float) -> void:
	_animation_player.speed_scale = GlobalTimer.get_factor()
