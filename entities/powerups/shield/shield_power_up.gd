extends PowerUp

func _apply_power_up(ship: Ship) -> void:
	ship.apply_shield_power_up()
