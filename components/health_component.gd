class_name HealthComponent
extends Node

signal health_changed()
signal death()
var is_dying: bool

@export var health: int = 1:
	set(value):
		health = value
		health_changed.emit()
		if health <= 0 and not is_dying:
			is_dying = true
			death.emit()

func add_health(amount: int) -> void:
	if health + amount <= 3:
		health += amount
