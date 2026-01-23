class_name ExternalRange
extends Area2D

@export var parent: Node2D;
@export var radius: int = 250

func _ready() -> void:
	assert(parent != null, "Parent is not set in ExternalRange")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	($CollisionShape2D.shape as CircleShape2D).radius = radius

func _on_body_entered(body: Node2D) -> void:
	if body is XpOrb:
		(body as XpOrb).set_target(parent)

func _on_body_exited(body: Node2D) -> void:
	if body is XpOrb: return
