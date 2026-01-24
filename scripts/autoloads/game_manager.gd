extends Node


var player_ps = preload(Constants.SCENE_PATH.player)


var player: Player
var player_rundata: PlayerRundata
var run_stats: RunStats


func _init() -> void:
	if not OS.is_debug_build():
		return
	
	print("Running in DEV mode.")
	## Usable only for DEV porpouses, IE running isolated scenes
	## Can also use some custom pre-populated data for development
	player = player_ps.instantiate()
	player_rundata = PlayerRundata.new()
	run_stats = RunStats.new()
	player.setup(player_rundata)


func fresh() -> void:
	if player:
		player.queue_free()
	player = null
	player_rundata = null
	run_stats = null


func start_new_run() -> void:
	fresh()
	
	player = player_ps.instantiate()
	player_rundata = PlayerRundata.new()
	run_stats = RunStats.new()
	
	player.setup(player_rundata)


func end_run() -> void:
	fresh()
