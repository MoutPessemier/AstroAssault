extends Node

const PATH_GAME_DATA := "user://data.save"
const PATH_SETTINGS_DATA := "user://settings.save"

var game_stats: GameStats = preload("res://resources/game_stats/game_stats.tres")
var music_stats: MusicStats = preload("res://resources/music_stats/music_stats.tres")

func save_game() -> void:
	var file = FileAccess.open(PATH_GAME_DATA, FileAccess.WRITE)
	file.store_var(game_stats.high_score)

func load_game() -> void:
	if FileAccess.file_exists(PATH_GAME_DATA):
		var file = FileAccess.open(PATH_GAME_DATA, FileAccess.READ)
		game_stats.high_score = file.get_var(game_stats.high_score)
	else:
		printerr("No data saved to file")
		game_stats.high_score = 0

func save_settings() -> void:
	var settings_data = {
		Constants.MASTER_KEY: music_stats.master_value,
		Constants.MUSIC_KEY: music_stats.music_value,
		Constants.SFX_KEY: music_stats.sfx_value
	}
	var file = FileAccess.open(PATH_SETTINGS_DATA, FileAccess.WRITE)
	file.store_var(settings_data)

func load_settings() -> void:
	if FileAccess.file_exists(PATH_SETTINGS_DATA):
		var file = FileAccess.open(PATH_SETTINGS_DATA, FileAccess.READ)
		var data = file.get_var()
		music_stats.master_value = data.get(Constants.MASTER_KEY)
		music_stats.music_value = data.get(Constants.MUSIC_KEY)
		music_stats.sfx_value = data.get(Constants.SFX_KEY)
	else:
		printerr("No data saved to file")
		music_stats.master_value = 1
		music_stats.music_value = 0.85
		music_stats.sfx_value = 1
	_apply_audio_settings()

func _apply_audio_settings() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(Constants.MASTER_KEY), linear_to_db(music_stats.master_value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(Constants.MUSIC_KEY), linear_to_db(music_stats.music_value))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(Constants.SFX_KEY), linear_to_db(music_stats.sfx_value))
