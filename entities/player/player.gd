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
@export var sfx_shooting_component: SfxComponent
@export var hurt_component: HurtComponent
@export var shield: Shield

func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)

func fire_lasers() -> void:
	laser_spawner.spawn(left_gun.global_position)
	laser_spawner.spawn(right_gun.global_position)
	scale_component.tween_scale()
	sfx_shooting_component.play_sfx()

func _process(_delta: float) -> void:
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

func apply_health_power_up(amount: int) -> void:
	hurt_component.add_health(amount)

func apply_shield_power_up() -> void:
	shield.enable_for(5.0)

func apply_speed_power_up() -> void:
	move_component.speed_up(1.5, 10)
