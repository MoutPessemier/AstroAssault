extends Node

const PATH := "user://data.save"

var game_stats: GameStats = preload("res://resources/game_stats/game_stats.tres")
var music_stats: MusicStats = preload("res://resources/music_stats/music_stats.tres")

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

func save_settings() -> void:
	var file = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_var(music_stats.master_value)
	file.store_var(music_stats.music_value)
	file.store_var(music_stats.sfx_value)

func load_settings() -> void:
	if FileAccess.file_exists(PATH):
		var file = FileAccess.open(PATH, FileAccess.READ)
		music_stats.master_value = file.get_var(music_stats.master_value)
		music_stats.music_value = file.get_var(music_stats.music_value)
		music_stats.sfx_value = file.get_var(music_stats.sfx_value)
		print("values are:")
		print(music_stats.master_value)
		print(music_stats.music_value)
		print(music_stats.sfx_value)
	else:
		print("No data saved to file")
		music_stats.master_value = 1
		music_stats.music_value = 0.85
		music_stats.sfx_value = 1
