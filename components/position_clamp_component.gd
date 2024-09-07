class_name PositionClampComponent
extends Node2D

var left_border = 0
var right_border = ProjectSettings.get_setting("display/window/size/viewport_width")

@export var entity: Node2D
@export var margin: int = 8

func _process(_delta: float) -> void:
	entity.global_position.x = clamp(entity.global_position.x, left_border + margin, right_border - margin)
