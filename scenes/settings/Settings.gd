extends Control

@export var back_button: TextureButton

var master_bus_index = AudioServer.get_bus_index("Master")
var music_bus_index = AudioServer.get_bus_index("Music")
var sfx_bus_index = AudioServer.get_bus_index("SoundEffects")

func _ready() -> void:
	back_button.pressed.connect(_on_back_button_pressed)

func _on_back_button_pressed() -> void:
	NavigationManager.navigate(NavigationManager.previous_scene_path, NavigationManager.was_paused)
