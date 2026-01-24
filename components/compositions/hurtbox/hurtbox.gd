class_name Hurtbox
extends Area2D


signal damage_taken(amount: float, source: Node)


@export var tick_rate: float = 0.5


var _active_hitboxes_queue: Array[Hitbox] = []
var _active_hitboxes: Array[Hitbox] = []
var _tick_timer := 0.0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _physics_process(delta: float) -> void:
	if _active_hitboxes.is_empty() && _active_hitboxes_queue.is_empty():
		return
	
	_tick_timer += delta
	if _tick_timer >= tick_rate:
		_apply_continuous_damage()
		_update_active_hitboxes()
		_tick_timer = 0.0


func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		_damage_owner(area.damage, area.source)
		_active_hitboxes_queue.append(area)


func _on_area_exited(area: Area2D) -> void:
	if area is Hitbox:
		_active_hitboxes.erase(area)
		_active_hitboxes_queue.erase(area)


func _apply_continuous_damage() -> void:
	for hitbox in _active_hitboxes:
		if hitbox.damage > 0.0:
			_damage_owner(hitbox.damage, hitbox.source)


func _update_active_hitboxes() -> void:
	for hitbox in _active_hitboxes_queue:
		_active_hitboxes.append(hitbox)
		_active_hitboxes_queue.erase(hitbox)


func _damage_owner(amount: float, source: Node) -> void:
	damage_taken.emit(amount, source)
