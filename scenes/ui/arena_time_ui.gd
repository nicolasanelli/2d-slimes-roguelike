extends CanvasLayer


@export var arena_time_manager: ArenaTimeManager

@onready var timer_label: Label = %TimerLabel


func _process(_delta: float) -> void:
	if arena_time_manager == null: return
	
	var time_elapsed = arena_time_manager.get_time_elapsed()
	timer_label.text = format_seconds_to_string(time_elapsed)


func format_seconds_to_string(seconds: float) -> String:
	var total_seconds := int(seconds)
	var minutes := total_seconds / 60.0
	var remaining_seconds := total_seconds % 60
	
	return "%02d:%02d" % [minutes, remaining_seconds]
