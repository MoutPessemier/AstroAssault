class_name DestroyedComponent
extends Node

@export var entity: Node2D # The entity to destroy
@export var health_component: HealthComponent
@export var destroy_effect_spawner_component: SpawnerComponent
@export var sfx_component: SfxComponent

func _ready() -> void:
	health_component.death.connect(destroy)

func destroy() -> void:
	sfx_component.play_sfx()
	destroy_effect_spawner_component.spawn(entity.global_position)
	await sfx_component.sfx_done_playing
	entity.queue_free()
