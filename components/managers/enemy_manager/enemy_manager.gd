class_name EnemyManager
extends Node2D


@export var _player: Player
@export var _camera: Camera2D
@export var _enabled: bool = true


@onready var _path: Path2D = %Path2D
@onready var _spawn_location: PathFollow2D = %SpawnLocation
@onready var _enemies: Node = %Enemies
@onready var _timer: Timer = %Timer
@onready var _dificulty_timer: Timer = %DificultyTimer


var _dificulty = 0


var _slime_component = preload("res://components/characters/slime/slime.tscn")
var _slime_resources: Array[SlimeResource] = [
	load("res://data/enemies/slime/001_green_slime.tres"),
	load("res://data/enemies/slime/002_darkgreen_slime.tres"),
	load("res://data/enemies/slime/003_blue_slime.tres"),
]

func _ready() -> void:
	assert(_player != null, "Player is not set in EnemyManager")
	assert(_camera != null, "Camera is not set in EnemyManager")
	_configure_scale()
	_configure_timer()


func _process(_delta: float) -> void:
	if !_player: return #TODO
	global_position = _player.global_position


func _configure_scale() -> void:
	_path.scale = Vector2.ONE / _camera.zoom


func _configure_timer() -> void:
	_timer.wait_time = 0.3
	_timer.timeout.connect(_on_timer_timeout)
	_timer.start()
	
	_dificulty_timer.wait_time = 30
	_dificulty_timer.timeout.connect(_on_dificulty_timer_timeout)
	_dificulty_timer.start()


func _on_timer_timeout() -> void:
	if _enabled:
		spawn_enemy()


func _on_dificulty_timer_timeout() -> void:
	_dificulty =  (_dificulty + 1) % _slime_resources.size()


func spawn_enemy() -> void:
	if !_player: return #TODO
	var enemy: Slime = _slime_component.instantiate()
	_spawn_location.progress_ratio = randf()
	enemy.global_position = _spawn_location.global_position
	enemy.set_target(_player)
	enemy.set_resource(_slime_resources[_dificulty])
	Debugger.instance.increaseMobSpawned()
	_enemies.add_child(enemy, true)
