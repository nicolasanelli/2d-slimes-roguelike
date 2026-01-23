extends Node


var player: Player = Player.new()
var run_stats: RunStats = RunStats.new() 


func start_new_run() -> void:
	player = Player.new()
	run_stats = RunStats.new()
