extends Node2D

const MARGIN = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@export var spawner_component: SpawnerComponent
@export var meteorite_spawn_timer: Timer
@export var shipwreck_spawn_timer: Timer
@export var METEORITE_SCENE: PackedScene
@export var SHIPWRECK_SCENE: PackedScene
@export var game_stats: GameStats

func _ready() -> void:
	meteorite_spawn_timer.timeout.connect(handle_spawn_meteorite.bind(METEORITE_SCENE, meteorite_spawn_timer, 1.5))
	shipwreck_spawn_timer.timeout.connect(handle_spawn_shipwreck.bind(SHIPWRECK_SCENE, shipwreck_spawn_timer, 6.0))
	
	game_stats.score_changed.connect(func(new_score: int):
		if new_score > 25:
			shipwreck_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
	)

func handle_spawn_meteorite(environment_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	spawner_component.scene = environment_scene
	spawner_component.spawn(Vector2(randf_range(MARGIN, screen_width - MARGIN), -16))
	var spawn_rate = time_offset / (0.35 + game_stats.score * 0.01)
	timer.start(spawn_rate + randf_range(0.5, 0.75))

func handle_spawn_shipwreck(environment_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	spawner_component.scene = environment_scene
	spawner_component.spawn(Vector2(randf_range(MARGIN + Constants.SHIPWRECK_WIDTH/2.0, screen_width - Constants.SHIPWRECK_WIDTH/2.0), -16))
	var spawn_rate = 15 + time_offset / (0.25 + game_stats.score * 0.01)
	timer.start(spawn_rate + randf_range(5, 15))
