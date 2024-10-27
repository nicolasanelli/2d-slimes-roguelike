class_name Player 
extends CharacterBody2D


#region Singleton
static var instance: Player

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@onready var _happy_boo: HappyBoo = %HappyBoo
@onready var _health_component: HealthComponent = %HealthComponent
@onready var _camera: Camera2D = $Camera2D


# TODO remover essa lógica do player
var _known_drops = {}

#var _weapons_dict = {}

func _ready() -> void:
	_health_component.health_depleted.connect(_on_health_depleted)

func _input(_event: InputEvent) -> void:
	if !_camera: return;
	
	var zoom_val = _camera.zoom.x
	if Input.is_action_just_pressed("zoom_in"):
		_camera.zoom = Vector2(zoom_val + 0.05, zoom_val + 0.05)
	if Input.is_action_just_pressed("zoom_out"):
		_camera.zoom = Vector2(zoom_val - 0.05, zoom_val - 0.05)

func _physics_process(_delta: float) -> void:
	var direction = PlayerInput.get_movement()
	
	velocity = direction * 600
	move_and_slide()
	
	if velocity.length() > 0.0:
		_happy_boo.play_walk_animation()
	else:
		_happy_boo.play_idle_animation()
	
	# TODO remover essa lógica do player
	var overlaping_drops = _xpbox.get_overlapping_bodies()
	if overlaping_drops.size() > 0:
		for n in overlaping_drops.size():
			var drop = overlaping_drops[n];
			drop.set_target_global_position(global_position)
			
			if _known_drops.has(drop.get_instance_id()): continue
			drop.xp_absorved.connect(add_experience)
			_known_drops[drop.get_instance_id()] = true


func _on_health_depleted() -> void:
	GameManager.instance.game_over()

	
# TODO remover essa lógica do player
var _level = 0
var _experiece: float = 0
var _total_experiece: float = 0
var _target_experience: float = 5
@onready var _xpbox: Area2D = %XpBox
func level_up() -> void:
	_level += 1
	_target_experience = round(pow(_level, 1.8) + _level + 5)

func add_experience(value: float) -> void:
	_experiece += value
	_total_experiece += value
	
	while _experiece >= _target_experience:
		_experiece -= _target_experience
		level_up()


func add_weapon(_weapon: Node2D) -> void:
	return;
	#var _name = weapon.get_weapon_name()
	#if _weapons_dict.has(_name): 
		#push_error("Trying to add a weapons is already in")
		#return
	#
	#%Weapons.add_child(weapon)
	#_weapons_dict[_name] = weapon

func get_pistol() -> Node2D:
	return %Weapons/Pistol
