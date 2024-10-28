class_name Player 
extends CharacterBody2D


signal player_leveled
signal player_died


@onready var _happy_boo: HappyBoo = %HappyBoo
@onready var _health_component: HealthComponent = %HealthComponent
@onready var _experience_component: ExperienceComponent = %ExperienceComponent


const SPEED = 600


func _ready() -> void:
	_health_component.health_depleted.connect(_on_health_depleted)
	_experience_component.leveled_up.connect(_on_leveled_up)



func _physics_process(_delta: float) -> void:
	var direction = PlayerInput.get_movement()
	
	velocity = direction * SPEED * GlobalTimer.get_factor()
	move_and_slide()
	
	if velocity.length() > 0.0:
		_happy_boo.play_walk_animation()
	else:
		_happy_boo.play_idle_animation()


func _on_health_depleted() -> void:
	## play animation, sounds, efx
	player_died.emit()


func _on_leveled_up() -> void:
	## play animation, sound, efx
	player_leveled.emit()
