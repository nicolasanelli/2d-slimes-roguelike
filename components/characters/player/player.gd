class_name Player
extends CharacterBody2D


@onready var happy_boo: HappyBoo = %HappyBoo
@onready var hurtbox: Hurtbox = $Hurtbox


var rundata: PlayerRundata# = PlayerRundata.new()
var input: PlayerInput = PlayerInput.new()
var state_machine: CallableStateMachine = CallableStateMachine.new()


func _ready() -> void:
	assert(rundata != null, "Player.setup() must be called before using Player")
	
	hurtbox.damage_taken.connect(_on_damage_taken)
	
	state_machine.add_state(state_idle, enter_state_idle, Callable())
	state_machine.add_state(state_walk, enter_state_walk, Callable())
	state_machine.set_initial_state(state_idle)


func setup(_rundata: PlayerRundata):
	self.rundata = _rundata


#region State Machine Region
func _physics_process(_delta: float) -> void:
	state_machine.update()
	
	
func enter_state_idle() -> void:
	happy_boo.play_idle_animation()


func state_idle() -> void:
	if input.is_movement():
		state_machine.change_state(state_walk)


func enter_state_walk() -> void:
	happy_boo.play_walk_animation()


func state_walk() -> void:
	var direction = input.get_movement()
	velocity = direction * 225
	move_and_slide()
	
	if !input.is_movement():
		state_machine.change_state(state_idle)
#endregion


func _on_damage_taken(amount: float, _source: Node) -> void:
	rundata.health_component.damage(amount)
