extends Node


var _mob_component = preload("res://components/characters/slime/slime.tscn")
@onready var _path: PathFollow2D = %PathFollow2D
@onready var _timer: Timer = %Timer
@onready var _mobs: Node = %Mobs


func _ready() -> void:
	_timer.wait_time = 0.3
	_timer.start()
	_timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout() -> void:
	spawn_mob()


func spawn_mob() -> void:
	var mob: Node2D = _mob_component.instantiate() 
	_path.progress_ratio = randf()
	mob.global_position = _path.global_position
	Debugger.instance.increaseMobSpawned()
	_mobs.add_child(mob, true)
