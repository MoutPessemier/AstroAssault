class_name GameStats
extends Resource

@export var score: int = 0:
	set(value):
		if value < score:
			minus_point.emit(value - score)
		score = value
		score_changed.emit(score)

@export var high_score: int = 0

@export var time: int = 0:
	set(value):
		time = value
		time_changed.emit(time)
		
@export var health: int = 3:
	set(value):
		health = value
		health_change.emit(health)

signal score_changed(new_score)
signal time_changed(new_time)
signal health_change(new_health)
signal minus_point(amount)
