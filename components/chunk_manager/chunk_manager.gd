class_name ChunkManager extends Node2D


#region Singleton
static var instance: ChunkManager

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@onready var chunks: Node = $Chunks

var _chunk_component = preload("res://components/chunk/chunk.tscn")

var player: Player
var chunks_loaded = {}


func _ready() -> void:
	player = Player.instance


func _process(_delta: float) -> void:
	_spawn_adjacent_chunks()
	

func _get_player_current_chunk() -> Vector2:
	var _position: Vector2 = player.get_global_position()
	return Chunk.get_x_y_for_global_position(_position)


func _spawn_adjacent_chunks() -> void:
	var pos = _get_player_current_chunk()
	var x = pos.x
	var y = pos.y
	for n in range(x-1, x+2):
		for m in range(y-1, y+2):
			_spawn_chunk(n, m)


func _spawn_chunk(x: int, y: int) -> void:
	var key = "chunk[%s,%s]" % [x, y]
	if chunks_loaded.has(key): return
	
	var chunk: Chunk = _chunk_component.instantiate()
	chunk.global_position = chunk.get_global_position_for_x_y(x, y)
	chunks.add_child(chunk)
	chunks_loaded[key] = true
	
