extends Node


var player: Player = Player.new()
var run_stats: RunStats = RunStats.new() 


func start_new_run() -> void:
	player = Player.new()
	run_stats = RunStats.new()


func _process(delta: float) -> void:
	run_stats.update_time_elapsed(delta)
