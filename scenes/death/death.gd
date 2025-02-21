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
	GameManager.reset_game_state()
	NavigationManager.navigate("res://scenes/world/world.tscn")

func _on_settings_button_pressed() -> void:
	NavigationManager.navigate("res://scenes/settings/settings.tscn")

func _on_home_button_pressed() -> void:
	DataManager.save_game()
	GameManager.reset_game_state()
	NavigationManager.navigate("res://scenes/start/start.tscn")

func _on_quit_button_pressed() -> void:
	DataManager.save_game()
	get_tree().quit()
