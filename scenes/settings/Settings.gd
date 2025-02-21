extends Control

@export var back_button: TextureButton

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	DataManager.save_settings()
	NavigationManager.navigate(NavigationManager.previous_scene_path, NavigationManager.was_paused)
