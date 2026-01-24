extends Node


var player_ps = preload(Constants.SCENE_PATH.player)


var player: Player
var player_rundata: PlayerRundata = PlayerRundata.new()
var run_stats: RunStats = RunStats.new() 


func start_new_run() -> void:
	player = player_ps.instantiate()
	player_rundata = PlayerRundata.new()
	run_stats = RunStats.new()
	
	player.setup(player_rundata)


func end_run() -> void:
	player.queue_free()
	player = null
	player_rundata = null
	run_stats = null
