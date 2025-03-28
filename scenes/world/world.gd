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
	game_stats.minus_point.connect(func(value): show_minus_label(value))
	elapsed_timer.timeout.connect(func():
		game_stats.time = game_stats.time + 1
	)
	connect_player_signals()
	pause_button.pressed.connect(pause_game)
	if NavigationManager.was_paused:
		SaveManager.schedule_state_restoration()
		get_tree().paused = true
		pause_menu.visible = true
		await get_tree().create_timer(0.1).timeout
		connect_player_signals()

func connect_player_signals() -> void:
	if not player or not player.health_component:
		return

	if player.health_component.death.is_connected(func(): NavigationManager.was_paused = false):
		player.health_component.death.disconnect(func(): NavigationManager.was_paused = false)
	if player.tree_exiting.is_connected(func(): handle_player_exit()):
		player.tree_exiting.disconnect(func(): handle_player_exit())
	
	player.health_component.death.connect(func():
		NavigationManager.was_paused = false
	)
	player.tree_exiting.connect(func():
		if not NavigationManager.was_paused:
			elapsed_timer.stop()
			await get_tree().create_timer(1.0).timeout
			NavigationManager.navigate("res://scenes/death/death.tscn")
	)
	

func update_score_label(new_score: int) -> void:
	score_label.text = "Score: " + str(new_score)

func update_time_label(time: int) -> void:
	var formatted_time = _format_time(time)
	time_label.text = "Time: " + formatted_time

func update_lives_label(lives_left: int) -> void:
	var lives_left_corrected = max(lives_left, 0)
	lives_label.text = "x" + str(lives_left_corrected)

func show_minus_label(value: int):
	minus_label.visible = true
	minus_label.text = str(value)
	await get_tree().create_timer(0.75).timeout
	minus_label.visible = false

func _format_time(time: int) -> String:
	var minutes = (int)(time / 60)
	var seconds = time % 60
	var s_minutes = str(minutes) if minutes > 9 else "0" + str(minutes)
	var s_seconds = str(seconds) if seconds > 9 else "0" + str(seconds)
	
	return s_minutes + ":" + s_seconds

func pause_game() -> void:
	get_tree().paused = true
	pause_menu.visible = true
