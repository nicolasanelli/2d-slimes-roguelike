extends Node2D


@onready var _rotation_point: Marker2D = %RotationPoint
var _sail_component = preload("res://components/sail/sail.tscn")

var _quantity = 2
var _radius = 250


func _ready() -> void:
	_draw_sails()

func get_quantity() -> int:
	return _quantity 


func increase_quantity() -> void:
	_quantity += 1
	_draw_sails()


func decrease_quantity() -> void:
	_quantity -= 1
	_draw_sails()


func get_radius() -> int:
	return _radius 


func increase_radius() -> void:
	_radius += 25
	_draw_sails()


func decrease_radius() -> void:
	_radius -= 25
	_draw_sails()


func _draw_sails() -> void:
	for n in _rotation_point.get_children():
		n.free()
	
	if visible:
		for n in _quantity:
			var sail: Area2D = _sail_component.instantiate()
			sail.position = Vector2(_radius, 0).rotated((n * 2) * PI / _quantity)
			_rotation_point.add_child(sail)
	
	#var sail1: Area2D = _sail_component.instantiate()
	#var sail2: Area2D = _sail_component.instantiate()
	#var sail3: Area2D = _sail_component.instantiate()
	#var sail4: Area2D = _sail_component.instantiate()
	#var sail5: Area2D = _sail_component.instantiate()
	#sail1.position = Vector2(250, 0).rotated(0 * PI / 5)
	#sail2.position = Vector2(250, 0).rotated(2 * PI / 5)
	#sail3.position = Vector2(250, 0).rotated(4 * PI / 5)
	#sail4.position = Vector2(250, 0).rotated(6 * PI / 5)
	#sail5.position = Vector2(250, 0).rotated(8 * PI / 5)
	#_rotation_point.add_child(sail1)
	#_rotation_point.add_child(sail2)
	#_rotation_point.add_child(sail3)
	#_rotation_point.add_child(sail4)
	#_rotation_point.add_child(sail5)


func _process(delta: float) -> void:
	rotation += 4 * delta
	pass
