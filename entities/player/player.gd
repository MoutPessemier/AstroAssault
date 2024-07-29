class_name Ship
extends Node2D

@onready var left_gun: Marker2D = $LeftGun
@onready var right_gun: Marker2D = $RightGun
@onready var spawner_component: SpawnerComponent = $SpawnerComponent
@onready var fire_rate_timer: Timer = $FireRateTimer
@onready var scale_component: ScaleComponent = $ScaleComponent

func _ready() -> void:
	fire_rate_timer.timeout.connect(fire_lasers)

func fire_lasers() -> void:
	spawner_component.spawn(left_gun.global_position)
	spawner_component.spawn(right_gun.global_position)
	scale_component.tween_scale()
