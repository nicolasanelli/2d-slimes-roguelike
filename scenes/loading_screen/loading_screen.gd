extends Control


@onready var loading_bar: TextureProgressBar = %LoadingProgress


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Loader.loading_progress_updated.connect(_on_progress_updated)


func _on_progress_updated(percentage) -> void:
	loading_bar.value = percentage
