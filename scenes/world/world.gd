extends Node2D

@export var player: Ship
@export var score_label: Label
@export var game_stats: GameStats

func _ready() -> void:
	update_score_label(game_stats.score)
	game_stats.score_changed.connect(update_score_label)
	player.tree_exiting.connect(func():
		await get_tree().create_timer(1.0).timeout
		get_tree().change_scene_to_file("res://scenes/death/death.tscn")
	)

func update_score_label(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)
