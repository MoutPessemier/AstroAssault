class_name HurtComponent
extends Node

@export var health_component: HealthComponent
@export var hurtbox_component: HurtboxComponent

func _ready() -> void:
	hurtbox_component.hurt.connect(func(hitbox_component: HitboxComponent):
		health_component.health -= hitbox_component.damage
	)
