class_name DropManager
extends Node2D


#region Singleton
static var instance: DropManager

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


func spawn(scene: Node2D, _global_position: Vector2) -> void:
	scene.global_position = _global_position
	call_deferred("add_child", scene)
