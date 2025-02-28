extends PowerUp

func _apply_power_up(ship: Ship) -> void:
	ship.apply_speed_power_up(1.5, 10)
