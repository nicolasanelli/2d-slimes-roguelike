extends Node


@export var loading_scene: PackedScene = preload("res://scenes/loading_screen/loading_screen.tscn")


signal loading_progress_updated(percentage)


var scene_path = null
var loading_scene_instance = null

func load_scene(caller: Node, path: String) -> void:
	scene_path = path

	loading_scene_instance = loading_scene.instantiate(); 
	get_tree().root.add_child(loading_scene_instance)
	
	ResourceLoader.load_threaded_request(scene_path)
	loading_progress_updated.emit(0)
	
	caller.queue_free()


func _process(_delta: float) -> void:
	if (!scene_path): return;
	
	var progress = []
	var loader_status = ResourceLoader.load_threaded_get_status(scene_path, progress)
		
	loading_progress_updated.emit(progress[0] * 100)
		
	if (loader_status == ResourceLoader.THREAD_LOAD_LOADED):
		var loaded_scene = (ResourceLoader.load_threaded_get(scene_path) as PackedScene).instantiate()
		
		get_tree().root.remove_child(loading_scene_instance)
		loading_scene_instance.free()
		get_tree().root.add_child(loaded_scene)
		
		scene_path = null
