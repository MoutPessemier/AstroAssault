extends Control

@export var play_again_button: TextureButton
@export var settings_button: TextureButton
@export var home_button: TextureButton
@export var quit_button: TextureButton
@export var game_stats: GameStats
@export var score_value: Label
@export var high_score_value: Label

func _ready() -> void:
	score_value.text = str(game_stats.score)
	play_again_button.pressed.connect(_on_play_again_buttonPressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	home_button.pressed.connect(_on_home_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	game_stats.high_score = max(game_stats.score, game_stats.high_score)
	high_score_value.text = str(game_stats.high_score)

func _on_play_again_buttonPressed() -> void:
	DataManager.save_game()
	reset_game_state()
	get_tree().change_scene_to_file("res://scenes/world/world.tscn")

func _on_settings_button_pressed() -> void:
	# TODO: add implementation to settings screen
	pass

func _on_home_button_pressed() -> void:
	DataManager.save_game()
	game_stats.score = 0
	get_tree().change_scene_to_file("res://scenes/start/start.tscn")

func _on_quit_button_pressed() -> void:
	DataManager.save_game()
	get_tree().quit()

func reset_game_state():
	game_stats.score = 0
	game_stats.time = 0
	game_stats.health = 3
