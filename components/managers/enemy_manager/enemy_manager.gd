class_name EnemyManager
extends Node2D


@export var _player: Player
@export var _camera: Camera2D
@export var _enabled: bool = true


@onready var _path: Path2D = %Path2D
@onready var _spawn_location: PathFollow2D = %SpawnLocation
@onready var _enemies: Node = %Enemies

@onready var _timer: CTimer = %CTimer
@onready var _wave_timer: CTimer = %WaveCTimer


var _current_wave: int = 0
var _current_slime_resource: int = 0
var _waves = {
	0 : {
		"spawn_time": 1,
		"resource_idx": 0,
		"wave_time": 25,
	},
	1: {
		"spawn_time": -1,
		"resource_idx": -1,
		"wave_time": 10,
	},
	2 : {
		"spawn_time": .1,
		"resource_idx": 4,
		"wave_time": 5,
	},
	3: {
		"spawn_time": -1,
		"resource_idx": -1,
		"wave_time": 10,
	},
	4: {
		"spawn_time": 1,
		"resource_idx": 1,
		"wave_time": 10,
	},
	5: {
		"spawn_time": -1,
		"resource_idx": -1,
		"wave_time": 10,
	},
	6: {
		"spawn_time": 0.3,
		"resource_idx": 2,
		"wave_time": 15,
	},
	7: {
		"spawn_time": -1,
		"resource_idx": -1,
		"wave_time": 10,
		"boss": {
			"resource_idx": 3,
		}
	}
}



var _slime_component = preload("res://components/characters/slime/slime.tscn")
var _slime_resources: Array[SlimeResource] = [
	load("res://data/enemies/slime/001_green_slime.tres"),
	load("res://data/enemies/slime/002_darkgreen_slime.tres"),
	load("res://data/enemies/slime/003_blue_slime.tres"),
	load("res://data/enemies/slime/004_green_boss_slime.tres"),
	load("res://data/enemies/slime/005_pink_slime.tres"),
]

func _ready() -> void:
	assert(_player != null, "Player is not set in EnemyManager")
	assert(_camera != null, "Camera is not set in EnemyManager")
	_configure_scale()
	_configure_timer()
	_configure_wave()


func _process(_delta: float) -> void:
	#if !_player: return #TODO
	global_position = _player.global_position


func _configure_scale() -> void:
	_path.scale = Vector2.ONE / _camera.zoom


func _configure_timer() -> void:
	_timer.timeout.connect(_on_timer_timeout)
	_wave_timer.timeout.connect(_on_wave_timer_timeout)


func _on_timer_timeout() -> void:
	if _enabled:
		spawn_slime()


func _on_wave_timer_timeout() -> void:
	#_current_wave = (_current_wave + 1) % _waves.size()
	_current_wave += 1
	if _current_wave > _waves.size()-1:
		_current_wave = randi_range(0, _waves.size()-1)
		
	_configure_wave()


func _configure_wave() -> void:
	_timer.stop()
	_wave_timer.stop()
	
	var wave = _waves.get(_current_wave)
	
	if wave.has("boss"):
		var boss: Slime = _slime_component.instantiate()
		boss.set_target(_player)
		boss.set_resource(_slime_resources[wave["boss"]["resource_idx"]])
		spawn_enemy(boss)
	
	_current_slime_resource = wave["resource_idx"]
	_timer.start(wave["spawn_time"])
	_wave_timer.start(wave["wave_time"])


func spawn_slime() -> void:
	if _current_slime_resource < 0: return
	
	var slime: Slime = _slime_component.instantiate()
	slime.set_target(_player)
	slime.set_resource(_slime_resources[_current_slime_resource])
	spawn_enemy(slime)

func spawn_enemy(enemy: Slime) -> void:
	_spawn_location.progress_ratio = randf()
	enemy.global_position = _spawn_location.global_position
	Statistics.add_spawned_mob()
	_enemies.add_child(enemy, true)
