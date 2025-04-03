extends Node2D


var modulate_a = 1
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.timeout.connect(_on_timeout)

func _process(delta):
	if Engine.get_frames_drawn() % 30 == 0:
		self.modulate.a = modulate_a
		if (modulate_a == 1):
			modulate_a = 0.5
		else:
			modulate_a = 1

func _on_timeout() -> void:
	queue_free()
