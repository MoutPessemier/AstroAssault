class_name PauseMenu
extends Control

@export var settings_button: TextureButton
@export var resume_button: TextureButton


func _ready() -> void:
	settings_button.pressed.connect(_on_settings_button_pressed)
	resume_button.pressed.connect(_on_resume_button_pressed)

func _on_settings_button_pressed() -> void:
	# TODO: add implementation to settings screen
	pass

func _on_resume_button_pressed() -> void:
	visible = false
	get_tree().paused = false
