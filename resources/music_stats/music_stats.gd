class_name MusicStats
extends Resource

@export var master_value: float = 1

@export var music_value: float = 0.85

@export var sfx_value: float = 1

func update_bus_value(bus_name: String, value: float) -> void:
	if bus_name == Constants.MASTER_KEY:
		master_value = value
	elif bus_name == Constants.MUSIC_KEY:
		music_value = value
	elif bus_name == Constants.SFX_KEY:
		sfx_value = value
	else:
		printerr("Invalid Audio Bus Name:: " + bus_name)

func get_matching_bus(bus_name: String) -> float:
	if bus_name == Constants.MASTER_KEY:
		return master_value
	elif bus_name == Constants.MUSIC_KEY:
		return music_value
	elif bus_name == Constants.SFX_KEY:
		return sfx_value
	else:
		return 1
