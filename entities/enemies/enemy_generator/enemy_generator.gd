extends Serialisable

const MARGIN = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@export var spawner_component: SpawnerComponent
@export var orbital_crawler_spawn_timer: Timer
@export var jolt_jumper_spawn_timer: Timer
@export var ORBITAL_CRAWLER_SCENE: PackedScene
@export var JOLT_JUMPER_SCENE: PackedScene
@export var game_stats: GameStats

func _ready() -> void:
	orbital_crawler_spawn_timer.timeout.connect(handle_spawn.bind(ORBITAL_CRAWLER_SCENE, orbital_crawler_spawn_timer))
	#jolt_jumper_spawn_timer.timeout.connect(handle_spawn.bind(JOLT_JUMPER_SCENE, jolt_jumper_spawn_timer))
	
	game_stats.score_changed.connect(func(new_score: int):
		if new_score > 20:
			jolt_jumper_spawn_timer.process_mode = Node.PROCESS_MODE_INHERIT
	)

func handle_spawn(enemy_scene: PackedScene, timer: Timer, time_offset: float = 1.0) -> void:
	spawner_component.scene = enemy_scene
	spawner_component.spawn(Vector2(randf_range(MARGIN, screen_width - MARGIN), -16))
	var spawn_rate = time_offset / (0.5 + game_stats.score * 0.01)
	timer.start(spawn_rate + randf_range(0.25, 0.5))

func serialise() -> Dictionary:
	var data = super.serialise()
	data["orbital_crawler_timer"] = {
		"time_left": orbital_crawler_spawn_timer.time_left,
		"process_mode": orbital_crawler_spawn_timer.process_mode
	}
	data["jolt_jumper_timer"] = {
		"time_left": jolt_jumper_spawn_timer.time_left,
		"process_mode": jolt_jumper_spawn_timer.process_mode
	}
	return data

func deserialise(data: Dictionary) -> void:
	super.deserialise(data)
	
	if data.has("orbital_crawler_timer"):
		orbital_crawler_spawn_timer.start(data.orbital_crawler_timer.time_left)
		orbital_crawler_spawn_timer.process_mode = data.orbital_crawler_timer.process_mode
	
	if data.has("jolt_jumper_timer"):
		jolt_jumper_spawn_timer.start(data.jolt_jumper_timer.time_left)
		jolt_jumper_spawn_timer.process_mode = data.jolt_jumper_timer.process_mode
