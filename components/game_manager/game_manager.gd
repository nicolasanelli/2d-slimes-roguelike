class_name GameManager extends Node

#region Singleton
static var instance: GameManager

func _init() -> void:
	if not instance: instance = self
	else: queue_free()
#endregion


@onready var _game_over_screen: CanvasLayer = %GameOverScreen
@onready var _mobile_game_layer: CanvasLayer = %MobileGameLayer
@onready var _replay_button: Button = %ReplayButton


func _ready() -> void:
	_replay_button.pressed.connect(_on_replay_pressed)


func _on_replay_pressed() -> void:
	_game_over_screen.visible = false
	_mobile_game_layer.visible = true
	Global.reset_game()


func game_over() -> void:
	_game_over_screen.visible = true
	_mobile_game_layer.visible = false
