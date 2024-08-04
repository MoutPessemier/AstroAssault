class_name Ship
extends Node2D

@export var left_gun: Marker2D
@export var right_gun: Marker2D
@export var laser_spawner: SpawnerComponent
@export var fire_rate_timer: Timer
@export var scale_component: ScaleComponent
@export var ship: AnimatedSprite2D
@export var fire: AnimatedSprite2D
@export var move_component: MoveComponent

func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)

func fire_lasers() -> void:
	laser_spawner.spawn(left_gun.global_position)
	laser_spawner.spawn(right_gun.global_position)
	scale_component.tween_scale()

func _process(delta: float) -> void:
	animate_ship()

func animate_ship() -> void:
	if move_component.velocity.x < 0:
		ship.play("turn_left")
		fire.play("turn_left")
	elif move_component.velocity.x > 0:
		ship.play("turn_right")
		fire.play("turn_right")
	else:
		ship.play("center")
		fire.play("center")
