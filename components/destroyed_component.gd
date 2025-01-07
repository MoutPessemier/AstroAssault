class_name DestroyedComponent
extends Node

@export var entity: Node2D # The entity to destroy
@export var health_component: HealthComponent
@export var destroy_effect_spawner_component: SpawnerComponent

func _ready() -> void:
	health_component.death.connect(destroy)

func destroy() -> void:
	destroy_effect_spawner_component.spawn(entity.global_position)
	entity.queue_free()
