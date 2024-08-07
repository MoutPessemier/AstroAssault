extends Control

@export var score_label: Label
@export var play_again_button: TextureButton
@export var quit_button: TextureButton

func _ready() -> void:
	# TODO: add score
	score_label.text = "Score: "
	play_again_button.pressed.connect(play_again)
	quit_button.pressed.connect(quit)
	# TODO: if highscore, save to game file

func play_again() -> void:
	get_tree().change_scene_to_file("res://scenes/world/world.tscn")

func quit() -> void:
	get_tree().change_scene_to_file("res://scenes/start/start.tscn")
