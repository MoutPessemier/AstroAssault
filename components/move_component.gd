class_name MoveComponent
extends Node

@export var entity: Node2D
@export var velocity: Vector2

func _process(delta: float) -> void:
	entity.translate(velocity * delta)
