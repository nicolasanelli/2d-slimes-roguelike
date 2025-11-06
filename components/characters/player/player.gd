class_name Player
extends CharacterBody2D


@onready var health_component: HealthComponent = %HealthComponent
@onready var experience_component: ExperienceComponent = %ExperienceComponent
@onready var happy_boo: HappyBoo = %HappyBoo


var resource : PlayerResource = preload("res://data/player/base.tres")
var state_machine: CallableStateMachine = CallableStateMachine.new()


func _ready() -> void:
	health_component.init(resource.health)
	health_component.health_depleted.connect(_on_health_depleted)
	health_component.damaged.connect(_on_damaged)
	health_component.healed.connect(_on_healed)
	
	experience_component.leveled_up.connect(_on_leveled_up)
	experience_component.experience_changed.connect(_on_experience_changed)
	
	state_machine.add_state(state_idle, enter_state_idle, Callable())
	state_machine.add_state(state_walk, enter_state_walk, Callable())
	state_machine.set_initial_state(state_idle)


#region State Machine Region
func _physics_process(_delta: float) -> void:
	state_machine.update()
	
	
func enter_state_idle() -> void:
	happy_boo.play_idle_animation()


func state_idle() -> void:
	if PlayerInput.is_movement():
		state_machine.change_state(state_walk)


func enter_state_walk() -> void:
	happy_boo.play_walk_animation()


func state_walk() -> void:
	var direction = PlayerInput.get_movement()
	velocity = direction * resource.move_speed * GlobalTimer.get_factor()
	move_and_slide()
	
	if !PlayerInput.is_movement():
		state_machine.change_state(state_idle)
#endregion


func _on_health_depleted() -> void:
	AudioManager.play_gameover()
	CommandDispatcher.player_died.emit()


func _on_damaged() -> void:
	CommandDispatcher.player_health_changed.emit(health_component)
	if GlobalTimer.get_factor() > 0:
		AudioManager.play_hurt()


func _on_healed() -> void:
	CommandDispatcher.player_health_changed.emit(health_component)
	AudioManager.play_heal()


func _on_leveled_up() -> void:
	CommandDispatcher.player_leveled.emit(experience_component)


func _on_experience_changed() -> void:
	CommandDispatcher.player_experience_changed.emit(experience_component)
