class_name MoveComponent
extends Node

@export var entity: Node2D
@export var velocity: Vector2
@export var speed_multiplier: float = 1.0

const BASE_SPEED_MULTIPLIER: float = 1.0

func _physics_process(delta: float) -> void:
	entity.translate(velocity * delta * speed_multiplier)

func speed_up(multiplier: float, duration: float) -> void:
	speed_multiplier = multiplier
	await get_tree().create_timer(duration).timeout
	speed_multiplier = BASE_SPEED_MULTIPLIER
