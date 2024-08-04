class_name HealthComponent
extends Node

signal health_changed()
signal death()

@export var health: int = 1:
	set(value):
		health = value
		health_changed.emit()
		if health == 0: 
			death.emit()
