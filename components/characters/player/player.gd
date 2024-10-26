class_name Player extends CharacterBody2D

#region Singleton
static var instance: Player

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@onready var _happy_boo: HappyBoo = %HappyBoo

@onready var _health_bar: ProgressBar = %HealthBar
@onready var _hurtbox: Area2D = %HurtBox

@onready var _xpbox: Area2D = %XpBox
@onready var _camera: Camera2D = $Camera2D


# Player Stats
var _health: float = 100.0
var _experiece: float = 0
var _target_experience: float = 5


# TODO remover essa lógica do player
var _known_drops = {}

# name = $node2D
var _weapons_dict = {}


func _ready() -> void:
	_health_bar.min_value = 0
	_health_bar.max_value = _health
	_health_bar.value = _health

func _input(_event: InputEvent) -> void:
	if !_camera: return;
	
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
	
	
	# TODO remover essa lógica do player
	var DAMAGE_RATE = 5.0
	var overlapping_mobs = _hurtbox.get_overlapping_bodies()
	
	if overlapping_mobs.size() > 0:
		_health -= DAMAGE_RATE * overlapping_mobs.size() * delta
		_health_bar.value = _health
		if _health <= 0.0:
			GameManager.instance.game_over()
	
	
	# TODO remover essa lógica do player
	var overlaping_drops = _xpbox.get_overlapping_bodies()
	if overlaping_drops.size() > 0:
		for n in overlaping_drops.size():
			var drop = overlaping_drops[n];
			drop.set_target_global_position(global_position)
			
			if _known_drops.has(drop.get_instance_id()): continue
			drop.xp_absorved.connect(add_experience)
			_known_drops[drop.get_instance_id()] = true


func level_up() -> void:
	_experiece = 0
	_target_experience *= 2

func add_experience(value: float) -> void:
	_experiece += value


func add_weapon(weapon: Node2D) -> void:
	return;
	var name = weapon.get_weapon_name()
	if _weapons_dict.has(name): 
		push_error("Trying to add a weapons is already in")
		return
	
	%Weapons.add_child(weapon)
	_weapons_dict[name] = weapon

func get_pistol() -> Node2D:
	return %Weapons/Pistol
