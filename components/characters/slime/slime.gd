class_name Slime
extends CharacterBody2D


var _explosion_component = preload("res://components/efx/smoke_explosion/smoke_explosion.tscn")
var _xp_orb_componemt = preload("res://components/drops/xp_orb/xp_orb.tscn")


var player: Player = Player.instance;
var _current_health: float

@export var _resource: SlimeResource
@onready var _slime: SlimeBody = %SlimeBody


func _ready() -> void:
	_current_health = _resource.health
	_slime.play_walk()


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * _resource.speed
	move_and_slide()


func take_damage(amount: float = 1.0) -> void:
	_current_health -= amount
	_slime.play_hurt()
	
	if _current_health <= 0:
		Debugger.instance.increaseMobKilled()
		spawn_explosion()
		drop_xp()
		queue_free()

func spawn_explosion() -> void:
	var smoke: Node2D = _explosion_component.instantiate()
	smoke.global_position = global_position
	get_parent().add_child(smoke)

func drop_xp() -> void:
	var xp: XpOrb = _xp_orb_componemt.instantiate()
	xp.global_position = global_position
	get_parent().add_child(xp)
