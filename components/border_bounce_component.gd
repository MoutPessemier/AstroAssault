class_name BorderBounceComponent
extends Node

@export var margin: = 8
@export var entity: Node2D
@export var move_component: MoveComponent

var left_border = 0
var right_border = ProjectSettings.get_setting("display/window/size/viewport_width")

func _process(_delta: float) -> void:
	if entity.global_position.x < left_border + margin:
		entity.global_position.x = left_border + margin
		move_component.velocity = move_component.velocity.bounce(Vector2.RIGHT)
	elif entity.global_position.x > right_border - margin:
		entity.global_position.x = right_border - margin
		move_component.velocity = move_component.velocity.bounce(Vector2.LEFT)
