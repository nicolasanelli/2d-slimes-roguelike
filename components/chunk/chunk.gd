class_name Chunk extends Node2D

@export var chunk_width: int = 1920;
@export var chunk_height: int = 1080;

@onready var collisionShape: CollisionShape2D = $Area2D/CollisionShape2D;
@onready var trees: Node = $Trees;
@onready var label: Label = $Label;

var _tree_component = preload("res://components/envinronment/pine_tree/pine_tree.tscn")

var chunk_x: int;
var chunk_y: int;

func _ready() -> void:
	
	collisionShape.shape.size.x = chunk_width
	collisionShape.shape.size.y = chunk_height
	
	chunk_x = floor(global_position.x / chunk_width) 
	chunk_y = floor(global_position.y / chunk_height)
	label.text = "(%s, %s)" % [chunk_x, chunk_y]
	_spawn_random_trees(randi_range(4, 5))


func get_global_position_for_x_y(x: int, y: int) -> Vector2:
	return Vector2(x * chunk_width, y * chunk_height)


static func get_x_y_for_global_position(_position: Vector2) -> Vector2:
	var tmp = Chunk.new()
	var x = floor(_position.x / tmp.chunk_width)
	var y = floor(_position.y / tmp.chunk_height)
	tmp.queue_free()
	return Vector2(x, y);


func _get_random_position() -> Vector2:
	var min_x = global_position.x
	var max_x = global_position.x + chunk_width
	
	var min_y = global_position.y
	var max_y = global_position.y + chunk_height
	
	return Vector2(randf_range(min_x, max_x), randf_range(min_y, max_y));


func _spawn_random_trees(quantity: int) -> void:
	for n in quantity:
		_spawn_tree(_get_random_position())


func _spawn_tree(_position: Vector2) -> void:
	var tree: Node2D = _tree_component.instantiate()
	trees.global_position = Vector2.ZERO
	tree.global_position = _position
	trees.add_child(tree)
