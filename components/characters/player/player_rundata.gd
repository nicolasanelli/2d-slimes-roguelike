class_name PlayerRundata


var health_component: HealthComponent
var experience_component: ExperienceComponent
var damage: float


func _init() -> void:
	health_component = HealthComponent.new(100)
	experience_component = ExperienceComponent.new()
	damage = 10
