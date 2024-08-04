class_name ShakeComponent
extends Node

var current_shake = 0

@export var sprite: Node2D
@export var shake_amount: = 2.0
@export var shake_duration: = 0.4

func tween_shake():
	current_shake = shake_amount
	var tween = create_tween()
	tween.tween_property(self, "current_shake", 0.0, shake_duration).from_current()

func _physics_process(delta: float) -> void:
	sprite.position = Vector2(randf_range(-current_shake, current_shake), randf_range(-current_shake, current_shake))
