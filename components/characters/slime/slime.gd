class_name Slime
extends CharacterBody2D


var _explosion_component = preload("res://components/efx/smoke_explosion/smoke_explosion.tscn")
var _xp_orb_componemt = preload("res://components/drops/xp_orb/xp_orb.tscn")


var _target: Node2D
var _current_health: float

@export var _resource: SlimeResource
@onready var _slime_body: SlimeBody = %SlimeBody


func _ready() -> void:
	assert(_target != null, "Target is not set in Slime")
	assert(_resource != null, "SlimeResource is not set in Slime")
	_current_health = _resource.health
	_slime_body.set_colors(_resource.color)
	_slime_body.play_walk()


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(_target.global_position)
	velocity = direction * _resource.speed
	move_and_slide()


func set_target(target: Node2D) -> void:
	_target = target;


func set_resource(resource: SlimeResource) -> void:
	_resource = resource;


func take_damage(amount: float = 1.0) -> void:
	_current_health -= amount
	_slime_body.play_hurt()
	
	if _current_health <= 0:
		Debugger.instance.increaseMobKilled()
		spawn_explosion()
		drop_xp()
		queue_free()


func spawn_explosion() -> void:
	var smoke: Node2D = _explosion_component.instantiate()
	smoke.global_position = global_position
	add_sibling(smoke, true)


func drop_xp() -> void:
	var xp: XpOrb = _xp_orb_componemt.instantiate()
	xp.set_experience_value(_resource.experience_drop)
	DropManager.instance.spawn(xp, global_position)