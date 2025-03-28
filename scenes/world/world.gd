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

const SIGNAL_CONNECTIONS = {
	"game_stats": [
		{"signal": "score_changed", "method": "update_score_label"},
		{"signal": "time_changed", "method": "update_time_label"},
		{"signal": "health_change", "method": "update_lives_label"},
		{"signal": "minus_point", "method": "show_minus_label"}
	],
	"player": [
		{"signal": "death", "method": "_on_player_death"},
		{"signal": "tree_exiting", "method": "handle_player_exit"}
	]
}

func _ready() -> void:
	_initialize_ui()
	_connect_signals()
	_handle_pause_state()

func _initialize_ui() -> void:
	update_score_label(game_stats.score)
	update_time_label(game_stats.time)
	update_lives_label(game_stats.health)
	elapsed_timer.timeout.connect(_on_timer_timeout)
	pause_button.pressed.connect(pause_game)

func _connect_signals() -> void:
	_connect_game_stats_signals()
	_connect_player_signals()

func _connect_game_stats_signals() -> void:
	for connection in SIGNAL_CONNECTIONS.game_stats:
		game_stats.connect(connection.signal, Callable(self, connection.method))

func _connect_player_signals() -> void:
	if not _is_player_valid():
		return
	
	_disconnect_existing_player_signals()
	_connect_new_player_signals()

func _is_player_valid() -> bool:
	return player and player.health_component

func _disconnect_existing_player_signals() -> void:
	for connection in SIGNAL_CONNECTIONS.player:
		var signal_name = connection.signal
		var method = connection.method
		if player.health_component.is_connected(signal_name, Callable(self, method)):
			player.health_component.disconnect(signal_name, Callable(self, method))

func _connect_new_player_signals() -> void:
	for connection in SIGNAL_CONNECTIONS.player:
		var signal_name = connection.signal
		var method = connection.method
		player.health_component.connect(signal_name, Callable(self, method))

func _handle_pause_state() -> void:
	if not NavigationManager.was_paused:
		return
	
	SaveManager.schedule_state_restoration()
	get_tree().paused = true
	pause_menu.visible = true
	await get_tree().create_timer(0.1).timeout
	_connect_player_signals()

func _on_timer_timeout() -> void:
	game_stats.time += 1

func _on_player_death() -> void:
	NavigationManager.was_paused = false

func handle_player_exit() -> void:
	if not NavigationManager.was_paused:
		elapsed_timer.stop()
		await get_tree().create_timer(1.0).timeout
		NavigationManager.navigate("res://scenes/death/death.tscn")

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
