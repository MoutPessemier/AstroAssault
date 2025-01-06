extends Control

@export var play_again_button: TextureButton
@export var quit_button: TextureButton
@export var game_stats: GameStats
@export var score_value: Label
@export var high_score_value: Label

func _ready() -> void:
	score_value.text = str(game_stats.score)
	play_again_button.pressed.connect(play_again)
	quit_button.pressed.connect(quit)
	game_stats.high_score = max(game_stats.score, game_stats.high_score)
	high_score_value.text = str(game_stats.high_score)

func play_again() -> void:
	DataManager.save_game()
	reset_game_state()
	get_tree().change_scene_to_file("res://scenes/world/world.tscn")

func quit() -> void:
	DataManager.save_game()
	game_stats.score = 0
	get_tree().change_scene_to_file("res://scenes/start/start.tscn")

func reset_game_state():
	game_stats.score = 0
	game_stats.time = 0
	game_stats.health = 3
