class_name CardManager
extends Node2D


@export var _player: Player

var _highlighted_card: ActionCard

func _ready() -> void:
	#assert(_player != null, "Player must be set in CardManager")
	pass


func _process(_delta: float) -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_click") and _highlighted_card:
		print_debug(_highlighted_card)
		_highlighted_card.activate(_player)
		_remove_card(_highlighted_card)


func _add_card() -> void:
	var _scene = preload("res://components/cards/action_card/action_card.tscn")
	var card: Control = _scene.instantiate()
	card.my_mouse_entered.connect(_on_card_touched)
	card.my_mouse_exited.connect(_on_card_untouched)
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)

func _add_card2() -> void:
	var _scene = preload("res://components/cards/upgrade_card/upgrade_card.tscn")
	var card: Control = _scene.instantiate()
	card.my_mouse_entered.connect(_on_card_touched)
	card.my_mouse_exited.connect(_on_card_untouched)
	$CanvasLayer/ColorRect/HBoxContainer.add_child(card)


func _remove_card(card: ActionCard) -> void:
	card.queue_free()
	_highlighted_card = null


func _on_card_touched(card: ActionCard) -> void:
	card.highlight()
	_highlighted_card = card

func _on_card_untouched(card: ActionCard) -> void:
	card.unhighlight()
	_highlighted_card = null
