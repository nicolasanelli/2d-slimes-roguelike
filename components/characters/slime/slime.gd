class_name Slime
extends CharacterBody2D


@onready var health_component: HealthComponent = %HealthComponent
@onready var _slime_body: SlimeBody = %SlimeBody
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var _resource: SlimeResource = preload("res://data/enemies/slime/basic.tres")
var state_machine: CallableStateMachine = CallableStateMachine.new()


var _explosion_component = preload("res://components/efx/smoke_explosion/smoke_explosion.tscn")
var target: Node2D


func _ready() -> void:
	Statistics.add_spawned_mob()
	
	health_component.init(_resource.health)
	
	state_machine.add_state(state_idle, enter_state_idle, Callable())
	state_machine.add_state(state_chase, enter_state_chase, Callable())
	state_machine.add_state(state_hurt, enter_state_hurt, Callable())
	state_machine.add_state(state_dead, Callable(), Callable())
	state_machine.set_initial_state(state_idle)


func _process(_delta: float) -> void:
	$Label.text = "%s|%s" % [health_component.get_current_health(), health_component.get_max_health()]


#region State Machine Region
func _physics_process(_delta: float) -> void:
	state_machine.update()
	target = Global.player
	
	
func enter_state_idle() -> void:
	_slime_body.play_idle()


func state_idle() -> void:
	if health_component.get_current_health() <= 0:
		state_machine.change_state(state_dead)
		
	if target != null:
		state_machine.change_state(state_chase)


func enter_state_chase():
	_slime_body.play_walk()


func state_chase():
	if target == null:
		state_machine.change_state(state_idle)
		
	navigation_agent.target_position = get_target_global_position()
	var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
	
	velocity = direction * _resource.speed * GlobalTimer.get_factor()
	move_and_slide()
	
	if health_component.get_current_health() <= 0:
		state_machine.change_state(state_dead)


func enter_state_hurt() -> void:
	_slime_body.play_hurt()
	AudioManager.play_slime_squish()


func state_hurt() -> void:
	state_machine.change_state(state_chase)


func state_dead():
	var smoke: Node2D = _explosion_component.instantiate()
	smoke.global_position = global_position
	add_sibling(smoke)
	
	queue_free()
	Statistics.add_mob_killed()
#endregion


func set_target(_target: Node2D) -> void:
	target = _target;


func get_target_global_position() -> Vector2:
	if target == null: return global_position
	return target.global_position


func get_damage() -> float:
	return _resource.damage


func get_experience_drop() -> float:
	return _resource.experience_drop


func take_damage(amount: float = 1.0) -> void:
	health_component.damage(amount)
	state_machine.change_state(state_hurt)
