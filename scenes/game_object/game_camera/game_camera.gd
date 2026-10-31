extends Camera2D

var target_position = Vector2.ZERO


func _ready() -> void:
	make_current()


func _process(delta: float) -> void:
	acquire_target()
	
	# https://www.rorydriscoll.com/2016/03/07/frame-rate-independent-damping-using-lerp/
	global_position = global_position.lerp(target_position, 1.0 - exp(-delta * 20))


func acquire_target() -> void:
	var player = get_tree().get_first_node_in_group("Player") as Player
	if player == null: return
	
	target_position = player.global_position
