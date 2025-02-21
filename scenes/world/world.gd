extends Node2D

@export var player: Ship
@export var score_label: Label
@export var time_label: Label
@export var game_stats: GameStats
@export var elapsed_timer: Timer
@export var lives_label: Label
@export var minus_label: Label
@export var pause_button: TextureButton
@export var pause_menu: PauseMenu

func _ready() -> void:
	update_score_label(game_stats.score)
	update_time_label(game_stats.time)
	update_lives_label(game_stats.health)
	game_stats.score_changed.connect(update_score_label)
	game_stats.time_changed.connect(update_time_label)
	game_stats.health_change.connect(update_lives_label)
	game_stats.minus_point.connect(show_minus_label)
	elapsed_timer.timeout.connect(func():
		game_stats.time = game_stats.time + 1
	)
	player.tree_exiting.connect(func():
		elapsed_timer.stop()
		await get_tree().create_timer(1.0).timeout
		NavigationManager.navigate("res://scenes/death/death.tscn")
	)
	pause_button.pressed.connect(pause_game)

func update_score_label(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)

func update_time_label(time: int) -> void:
	var formatted_time = _format_time(time)
	time_label.text = "Time: " + formatted_time

func update_lives_label(lives_left: int) -> void:
	var lives_left_corrected = max(lives_left, 0)
	lives_label.text = "x" + str(lives_left_corrected)

func show_minus_label():
	minus_label.visible = true
	await get_tree().create_timer(0.75).timeout
	minus_label.visible = false

func _format_time(time: int) -> String:
	var minutes = time / 60
	var seconds = time % 60
	var s_minutes = str(minutes) if minutes > 9 else "0" + str(minutes)
	var s_seconds = str(seconds) if seconds > 9 else "0" + str(seconds)
	
	return s_minutes + ":" + s_seconds

func pause_game() -> void:
	get_tree().paused = true
	pause_menu.visible = true
