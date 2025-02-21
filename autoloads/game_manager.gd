extends Node

var game_stats: GameStats = load("res://resources/game_stats/game_stats.tres")

func reset_game_state():
	game_stats.score = 0
	game_stats.time = 0
	game_stats.health = 3
