extends Control


@onready var loading_bar: TextureProgressBar = %LoadingProgress


func _ready() -> void:
	Loader.loading_progress_updated.connect(_on_progress_updated)


func _on_progress_updated(percentage) -> void:
	loading_bar.value = percentage
