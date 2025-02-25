class_name PowerUp
extends Node2D

@export var visible_on_screen_notifier_2d: VisibleOnScreenNotifier2D
@export var pickup_range: Area2D
@export var move_component: MoveComponent

func _ready() -> void:
	visible_on_screen_notifier_2d.screen_exited.connect(queue_free)
	pickup_range.area_entered.connect(_on_power_up_pick_up)
	move_component.velocity = Vector2(_generate_random_x(), 30)

func _on_power_up_pick_up(hurtbox: HurtboxComponent) -> void:
	if hurtbox.get_parent().name == "Player":
		var ship: Ship = hurtbox.get_parent()
		_apply_power_up(ship)
		queue_free()

func _apply_power_up(ship: Ship) -> void:
	print("Super class Power Up should not have a power up!")

func _generate_random_x() -> int:
	var random_number = RandomNumberGenerator.new().randf()
	if random_number <= 0.5:
		return 25
	else:
		return -25
