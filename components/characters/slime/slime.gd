class_name Slime
extends CharacterBody2D


signal died(where: Vector2, xp_amount: float)


@onready var _slime_body: SlimeBody = %SlimeBody
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var hurtbox: Hurtbox = $Hurtbox
@export var target_offset_radius: float = 32.0
@export var repath_interval := 0.5
var _repath_timer := randf() * 0.5


var _resource: SlimeResource = preload("res://data/enemies/slime/basic.tres")
var _explosion_ps: PackedScene = preload(Constants.SCENE_PATH.smoke_explosion)


var target: Node2D
var health_component: HealthComponent
var state_machine: CallableStateMachine = CallableStateMachine.new()


func _ready() -> void:
	target = GameManager.player
	
	health_component = HealthComponent.new(_resource.health)
	health_component.health_depleted.connect(_on_health_depleted)
	health_component.damaged.connect(_on_damage)
	
	hurtbox.damage_taken.connect(_on_damage_taken)
	
	state_machine.add_state(state_idle, enter_state_idle, Callable())
	state_machine.add_state(state_chase, enter_state_chase, Callable())
	state_machine.add_state(state_hurt, enter_state_hurt, Callable())
	state_machine.add_state(state_dead, enter_state_dead, Callable())
	state_machine.set_initial_state(state_idle)
	
	navigation_agent.avoidance_enabled = true
	navigation_agent.radius = 12.0
	navigation_agent.max_speed = _resource.speed


#region State Machine Region
func _physics_process(delta: float) -> void:
	_repath_timer = max(0, _repath_timer - delta)
	state_machine.update()


func enter_state_idle() -> void:
	_slime_body.play_idle()


func state_idle() -> void:
	if target != null:
		state_machine.change_state(state_chase)


func enter_state_chase():
	_slime_body.play_walk()


func state_chase():
	if target == null:
		state_machine.change_state(state_idle)
	
	if _repath_timer <= 0:
		var variation := Vector2(
			randf_range(-target_offset_radius, target_offset_radius),
			randf_range(-target_offset_radius, target_offset_radius)
		)
		navigation_agent.target_position = target.global_position + variation
		
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()
		velocity = global_position.direction_to(next_path_position) * _resource.speed
		_repath_timer = repath_interval
	
	move_and_slide()


func enter_state_hurt() -> void:
	_slime_body.play_hurt()
	#AudioManager.play_slime_squish()


func state_hurt() -> void:
	state_machine.change_state(state_chase)
	

func enter_state_dead():
	var smoke: Node2D = _explosion_ps.instantiate()
	smoke.global_position = global_position
	add_sibling(smoke)
	
	died.emit(global_position, _resource.experience_drop)
	
	queue_free()


func state_dead():
	pass
#endregion


#region signals
func _on_health_depleted() -> void:
	state_machine.change_state(state_dead)


func _on_damage(_amount: float) -> void:
	state_machine.change_state(state_hurt)
#endregion


func take_damage(amount: float = 1.0) -> void:
	health_component.damage(amount)


func _on_damage_taken(amount: float, _source: Node) -> void:
	take_damage(amount)
