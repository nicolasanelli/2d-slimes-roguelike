class_name PickupMagnet
extends Area2D


@export var radius: int = 250
@onready var parent := get_parent() as Node2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	assert(parent != null, "PickupMagnet must be child of a Node2D")
	
	(collision_shape_2d.shape as CircleShape2D).radius = radius
	
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	# TODO: Refactor to pickup interface when more pickup types exist
	if body is XpOrb:
		(body as XpOrb).set_target(parent)
