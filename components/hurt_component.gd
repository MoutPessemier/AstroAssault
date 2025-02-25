class_name HurtComponent
extends Node

@export var health_component: HealthComponent
@export var hurtbox_component: HurtboxComponent
@export var game_stats: GameStats

func _ready() -> void:
	hurtbox_component.hurt.connect(func(hitbox_component: HitboxComponent):
		health_component.health -= hitbox_component.damage
		if health_component.get_parent().name == "Player":
			game_stats.health -= hitbox_component.damage
	)

func add_health(amount: int) -> void:
	health_component.health = min(3, health_component.health + 1)
	game_stats.health = min(3, game_stats.health + 1)
