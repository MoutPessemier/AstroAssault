extends PowerUp

func _apply_power_up(ship: Ship) -> void:
	ship.apply_health_power_up(1)
