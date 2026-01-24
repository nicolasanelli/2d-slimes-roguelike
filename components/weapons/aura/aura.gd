class_name Aura
extends Hitbox

#@export var damage: float = 1.0
#@export var tick_rate: float = 0.5

#var _targets := {}
#var _timer := 0.0

#func _ready() -> void:
	#monitoring = false
	#monitorable = true
	#input_pickable = false
	#body_entered.connect(_on_body_entered)
	#body_exited.connect(_on_body_exited)

#func _physics_process(delta: float) -> void:
	#if _targets.is_empty():
		#return
#
	#_timer += delta
	#if _timer >= tick_rate:
		#_timer = 0.0
		#_apply_damage()
#
#func _on_body_entered(body: Node2D) -> void:
	#if body.has_method("take_damage"):
		#_targets[body] = true
#
#func _on_body_exited(body: Node2D) -> void:
	#_targets.erase(body)
#
#func _apply_damage() -> void:
	#for target in _targets.keys():
		#if is_instance_valid(target):
			#target.take_damage(damage)
