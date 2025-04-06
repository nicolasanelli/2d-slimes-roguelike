class_name EnemyManager
extends Node2D


@export var _player: Player
@export var _camera: Camera2D
@export var _wave_timer_enabled: bool = true


@onready var _path: Path2D = %Path2D
@onready var _spawn_location: PathFollow2D = %SpawnLocation
@onready var _enemies: Node = %Enemies

@onready var _spawn_timer: CTimer = %SpawnCTimer
@onready var _wave_timer: CTimer = %WaveCTimer

var _stage := 1
var _stage_multiplier := [
	0, 1, 2, 3, 5, 7
]
var _wave := 1
var _waves := [
	{},
	{ # XP: 15
		"spawn_time": 2,
		"resource": preload("res://data/enemies/slime/001_green_slime.tres"),
		"wave_time": 31,
	},
	{
		"spawn_time": null,
		"resource": null,
		"wave_time": 4,
	},
	{ # XP: 30
		"spawn_time": 1,
		"resource": preload("res://data/enemies/slime/002_darkgreen_slime.tres"),
		"wave_time": 16,
	},
	{
		"spawn_time": null,
		"resource": null,
		"wave_time": 9,
	},
	{ # XP: 15
		"spawn_time": 1,
		"resource": preload("res://data/enemies/slime/003_blue_slime.tres"),
		"wave_time": 16,
	},
	{
		"spawn_time": null,
		"resource": null,
		"wave_time": 9,
	},
	{ # XP: 60
		"spawn_time": 0.5,
		"resource": preload("res://data/enemies/slime/004_pink_slime.tres"),
		"wave_time": 10,
	},
	{
		"spawn_time": null,
		"resource": null,
		"wave_time": 10,
	},
	{ #XP: 25
		"spawn_time": null,
		"resource": null,
		"wave_time": null,
		"boss": {
			"resource": preload("res://data/enemies/slime/005_green_boss_slime.tres"),
		}
	}
]


var _slime_component = preload("res://components/characters/slime/slime.tscn")


func _ready() -> void:
	assert(_player != null, "Player is not set in EnemyManager")
	assert(_camera != null, "Camera is not set in EnemyManager")
	_configure_scale()
	_configure_timer()
	_play_wave(_stage, _wave)


func _process(_delta: float) -> void:
	global_position = _player.global_position


func _configure_scale() -> void:
	_path.scale = Vector2.ONE / _camera.zoom


func _configure_timer() -> void:
	_spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	_wave_timer.timeout.connect(_to_next_wave)


func _on_spawn_timer_timeout() -> void:
	if _wave_timer_enabled && _wave <= _waves.size() && _stage <= _stage_multiplier.size():
		var slime := _create_slime(_stage, _wave)
		if slime: _spawn_enemy(slime)


func _to_next_wave() -> void:
	_wave += 1
	if _wave >= _waves.size():
		_wave = 1
		_stage +=1
	
	if _stage >= _stage_multiplier.size():
		CommandDispatcher.victory.emit()
	
	_play_wave(_stage, _wave)


func _play_wave(stage: int, wave: int) -> void:
	CommandDispatcher.level_info_updated.emit("Stage: %d/%d\nWave:  %d/%d" % [stage, _stage_multiplier.size() - 1, wave, _waves.size() - 1])
	
	_spawn_timer.stop()
	_wave_timer.stop()
	
	var wave_config = _waves.get(wave)
	
	if wave_config.has("boss"):
		var boss: Slime = _slime_component.instantiate()
		boss.set_target(_player)
		boss.set_resource(wave_config["boss"]["resource"], _stage_multiplier[_stage])
		boss.health_depleted.connect(_to_next_wave)
		_spawn_enemy(boss)
	
	if wave_config.has("wave_time") and wave_config.get("wave_time"):
		_wave_timer.start(wave_config["wave_time"])
	
	if wave_config.has("spawn_time") and wave_config.get("spawn_time"):
		_spawn_timer.start(wave_config["spawn_time"])


func _create_slime(stage: int, wave: int) -> Slime:
	var resource = _waves.get(wave)["resource"]
	if not resource : return null
	
	var slime: Slime = _slime_component.instantiate()
	slime.set_target(_player)
	slime.set_resource(resource, _stage_multiplier[stage])
	
	return slime


func _spawn_enemy(enemy: Slime) -> void:
	_spawn_location.progress_ratio = randf()
	enemy.global_position = _spawn_location.global_position
	_enemies.add_child(enemy, true)
