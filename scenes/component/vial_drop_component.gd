extends Node

@export_range(0, 1) var drop_percent: float = .5
@export var health_component: HealthComponent
@export var vial_scene: PackedScene

func _ready() -> void:
	health_component.died.connect(_on_died)


func _on_died() -> void:
	if vial_scene == null:
		push_warning("VialScene is not assigned to VialDropComponent")
		return
	
	if not owner is Node2D:
		push_warning("Owner is not a Node2D at VialDropComponent")
		return
	
	if randf() > drop_percent:
		return
	
	var spawn_position := (owner as Node2D).global_position
	var vial_instance := vial_scene.instantiate() as Node2D
	owner.get_parent().add_child(vial_instance) # TODO Set a better place/strategy to spawn items in the scene tree
	vial_instance.global_position = spawn_position
