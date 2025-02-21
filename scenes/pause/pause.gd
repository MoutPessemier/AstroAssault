class_name PauseMenu
extends Control

@export var resume_button: TextureButton
@export var settings_button: TextureButton
@export var home_button: TextureButton
@export var quit_button: TextureButton


func _ready() -> void:
	resume_button.pressed.connect(_on_resume_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	home_button.pressed.connect(_on_home_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_resume_button_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_settings_button_pressed() -> void:
	NavigationManager.navigate("res://scenes/settings/settings.tscn", true)

func _on_home_button_pressed() -> void:
	get_tree().paused = false
	GameManager.reset_game_state()
	NavigationManager.navigate("res://scenes/start/start.tscn")

func _on_quit_button_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()
