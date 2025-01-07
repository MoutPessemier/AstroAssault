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
	sfx_component.sfx_done_playing.connect(func():
		sfx_component.queue_free()
	)
	entity.queue_free()
