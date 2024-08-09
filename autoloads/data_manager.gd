extends Node

const PATH := "user://data.save"

var game_stats: GameStats = preload("res://resources/game_stats/game_stats.tres")

func save_game() -> void:
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_var(game_stats.high_score)

func load_game() -> void:
	if FileAccess.file_exists(PATH):
		var file = FileAccess.open(PATH, FileAccess.READ)
		game_stats.high_score = file.get_var(game_stats.high_score)
	else:
		print("No data saved to file")
		game_stats.high_score = 0
