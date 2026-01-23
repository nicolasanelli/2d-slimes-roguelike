extends Node2D


var pistol_sfx = preload(Constants.AUDIO_SFX.pistol_shot)
var hurt_sfx = preload(Constants.AUDIO_SFX.hurt)
var heal_sfx = preload(Constants.AUDIO_SFX.heal)
var pickup_sfx = preload(Constants.AUDIO_SFX.pickup)
var levelup_sfx = preload(Constants.AUDIO_SFX.levelup)
var click_sfx = preload(Constants.AUDIO_SFX.click)
var gameover_sfx = preload("res://assets/audio/sfx/gameover.mp3")
var slime_squish_sfx = preload("res://assets/audio/sfx/slime-squish.mp3")


@onready var hurt_player: AudioStreamPlayer2D = %HurtPlayer
@onready var pìckup_timer: Timer = %PìckupTimer
@onready var sfx_group: Node2D = %SFXGroup
@onready var audio_player_music: AudioStreamPlayer2D = %AudioPlayerMusic


var target: Node2D;


func _ready() -> void:
	pìckup_timer.timeout.connect(_on_pìckup_timer_timeout)


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
	audio_player.pitch_scale += randf_range(0, 0.15)
	audio_player.play()


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
	audio_player.pitch_scale += randf_range(0, 0.3)
	audio_player.play()

func _on_slime_squish_end() -> void:
	slime_squishs -= 1

func play_hurt() -> void:
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
	pickup_pitch += 0.02


var pickup_pitch := 0.0
func _on_pìckup_timer_timeout() -> void:
	pickup_pitch = 0.0
	

func play_click() -> void:
	var audio_player := AudioStreamPlayer2D.new()
	sfx_group.add_child(audio_player)
	
	audio_player.stream = click_sfx
	audio_player.finished.connect(audio_player.queue_free)
	audio_player.bus = "SFX"
	audio_player.volume_db = 15
	audio_player.pitch_scale += randf_range(0, 0.15)
	audio_player.play()
