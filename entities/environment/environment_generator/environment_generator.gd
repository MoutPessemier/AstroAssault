extends Node2D

const MARGIN = 8
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")

@export var spawner_component: SpawnerComponent
@export var meteorite_spawn_timer: Timer
@export var shipwreck_spawn_timer: Timer
@export var METEORITE_SCENE: PackedScene
@export var SHIPWRECK_SCENE: PackedScene

func _ready() -> void:
	meteorite_spawn_timer.timeout.connect(handle_spawn.bind(METEORITE_SCENE, meteorite_spawn_timer))
	#shipwreck_spawn_timer.timeout.connect(handle_spawn.bind(SHIPWRECK_SCENE, shipwreck_spawn_timer))

func handle_spawn(environment_scene: PackedScene, timer: Timer) -> void:
	spawner_component.scene = environment_scene
	spawner_component.spawn(Vector2(randf_range(MARGIN, screen_width - MARGIN), -16))
	timer.start()
