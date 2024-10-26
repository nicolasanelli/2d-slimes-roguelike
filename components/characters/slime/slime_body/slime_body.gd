class_name SlimeBody
extends Node2D


func play_walk():
	%AnimationPlayer.play("walk")


func play_hurt():
	%AnimationPlayer.play("hurt")
	%AnimationPlayer.queue("walk")


func set_colors(body: Color) -> void:
	%SlimeBody.self_modulate = body
