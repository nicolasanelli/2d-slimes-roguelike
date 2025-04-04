extends Node2D

@onready var audio_player_music: AudioStreamPlayer2D = $AudioPlayerMusic
@onready var sfx_group: Node2D = $SFXGroup


var target: Node2D;

var pistol_sfx = preload("res://assets/audio/sfx/pistol.mp3")
var shotgun_sfx = preload("res://assets/audio/sfx/shotgun.mp3")
var saw_sfx = preload("res://assets/audio/sfx/saw.mp3")
var slime_squish_sfx = preload("res://assets/audio/sfx/slime-squish.mp3")
var hurt_sfx = preload("res://assets/audio/sfx/hurt.mp3")
var heal_sfx = preload("res://assets/audio/sfx/heal.mp3")
var pickup_sfx = preload("res://assets/audio/sfx/pickup.wav")
var levelup_sfx = preload("res://assets/audio/sfx/levelup.mp3")
var click_sfx = preload("res://assets/audio/sfx/click.ogg")
var gameover_sfx = preload("res://assets/audio/sfx/gameover.mp3")


@onready var saw_player: AudioStreamPlayer2D = $SFXFixed/SawPlayer
@onready var hurt_player: AudioStreamPlayer2D = $SFXFixed/HurtPlayer
@onready var pìckup_timer: Timer = $PìckupTimer


func _ready() -> void:
	saw_player.stream = saw_sfx
	saw_player.bus = "SFX"
	saw_player.volume_db = -10


func _process(_delta: float) -> void:
	if target and target.global_position:
		global_position = target.global_position


func stick_to(_target: Node2D) -> void:
	target = _target


func play_background_music() -> void:
	if !audio_player_music.is_playing():
		audio_player_music.play()


func stop_all_sfx() -> void:
	var sfxs = sfx_group.get_children()
	saw_player.stop()
	hurt_player.stop()
	for sfx in sfxs:
		sfx.free()

func play_pistol() -> void:
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = pistol_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.volume_db = -5
	audio_player.pitch_scale += randf_range(-0.15, 0.15)
	audio_player.play()


func play_shotgun() -> void:
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = shotgun_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.volume_db = 0
	audio_player.pitch_scale += randf_range(-0.3, 0.3)
	audio_player.play()


func play_saw() -> void:
	saw_player.play()

func stop_saw() -> void:
	saw_player.stop()

var slime_squishs = 0
func play_slime_squish() -> void:
	if slime_squishs >= 6: return
	
	slime_squishs += 1
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = slime_squish_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.finished.connect(_on_slime_squish_end)
	audio_player.bus = "SFX"
	audio_player.volume_db = -15
	audio_player.pitch_scale += randf_range(-0.3, 0.3)
	audio_player.play()

func _on_slime_squish_end() -> void:
	slime_squishs -= 1

func play_hurt() -> void:
	hurt_player.pitch_scale += randf_range(-0.15, 0.15)
	if hurt_player.is_playing(): return
	
	hurt_player.stream = hurt_sfx
	hurt_player.bus = "SFX"
	hurt_player.play()

func play_heal() -> void:
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = heal_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.volume_db = 0
	audio_player.play()


func play_levelup() -> void:
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = levelup_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.volume_db = 10
	audio_player.play()


func play_gameover() -> void:
	var audio_player := AudioStreamPlayer2D.new()
	$SFXFixed.add_child(audio_player)
	
	audio_player.stream = gameover_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.volume_db = 0
	audio_player.play()
	
func play_pickup() -> void:
	pìckup_timer.start(1)
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = pickup_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.pitch_scale += pickup_pitch
	audio_player.play()
	pickup_pitch += 0.01


var pickup_pitch := -0.3
func _on_pìckup_timer_timeout() -> void:
	pickup_pitch = -0.3
	

func play_click() -> void:
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = click_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.volume_db = 15
	audio_player.pitch_scale += randf_range(-0.15, 0.15)
	audio_player.play()
	
