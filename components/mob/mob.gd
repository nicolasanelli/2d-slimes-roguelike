class_name Mob extends CharacterBody2D


var player: Player = Player.instance;
@onready var _slime: Slime = %Slime
var _explosion_component = preload("res://assets/smoke_explosion/smoke_explosion.tscn")

var _health = 3


func _ready() -> void:
	_slime.play_walk()


func _physics_process(_delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 300
	move_and_slide()


func take_damage(amount: float = 1.0) -> void:
	_health -= amount
	_slime.play_hurt()
	
	if _health <= 0:
		Debugger.instance.increaseMobKilled()
		queue_free()
		var smoke: Node2D = _explosion_component.instantiate()
		smoke.global_position = global_position
		get_parent().add_child(smoke)
