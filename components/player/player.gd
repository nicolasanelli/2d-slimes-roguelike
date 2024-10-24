class_name Player extends CharacterBody2D

#region Singleton
static var instance: Player

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@onready var _happy_boo: HappyBoo = %HappyBoo
@onready var _hurtbox: Area2D = %HurtBox
@onready var _health_bar: ProgressBar = %HealthBar
@onready var _camera: Camera2D = $Camera2D

var _health: float = 100.0


func _ready() -> void:
	_health_bar.min_value = 0
	_health_bar.max_value = _health
	_health_bar.value = _health


func _input(event: InputEvent) -> void:
	if !Debugger.instance.visible: return;
	
	var zoom_val = _camera.zoom.x
	if Input.is_action_just_pressed("zoom_in"):
		_camera.zoom = Vector2(zoom_val + 0.05, zoom_val + 0.05)
	if Input.is_action_just_pressed("zoom_out"):
		_camera.zoom = Vector2(zoom_val - 0.05, zoom_val - 0.05)


func _physics_process(delta: float) -> void:
	var direction = PlayerInput.get_movement()
	
	if _health > 0:
		velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		_happy_boo.play_walk_animation()
	else:
		_happy_boo.play_idle_animation()
	
	var DAMAGE_RATE = 5.0
	var overlapping_mobs = _hurtbox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		_health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		_health_bar.value = _health
		if _health <= 0.0:
			GameManager.instance.game_over()
