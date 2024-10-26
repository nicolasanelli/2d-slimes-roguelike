class_name EnemyManager
extends Node2D


@export var _player: Player
@export var _camera: Camera2D


@onready var _path: Path2D = %Path2D
@onready var _spawn_location: PathFollow2D = %SpawnLocation
@onready var _enemies: Node = %Enemies
@onready var _timer: Timer = %Timer


var _slime_component = preload("res://components/characters/slime/slime.tscn")


func _ready() -> void:
	assert(_player != null, "Player is not set in EnemyManager")
	assert(_camera != null, "Camera is not set in EnemyManager")
	_configure_scale()
	_configure_timer()


func _process(_delta: float) -> void:
	global_position = _player.global_position


func _configure_scale() -> void:
	_path.scale = Vector2.ONE / _camera.zoom

func _configure_timer() -> void:
	_timer.wait_time = 0.3
	_timer.timeout.connect(_on_timer_timeout)
	_timer.start()


func _on_timer_timeout() -> void:
	spawn_enemy()


func spawn_enemy() -> void:
	var enemy: Slime = _slime_component.instantiate() 
	_spawn_location.progress_ratio = randf()
	enemy.global_position = _spawn_location.global_position
	Debugger.instance.increaseMobSpawned()
	_enemies.add_child(enemy, true)
