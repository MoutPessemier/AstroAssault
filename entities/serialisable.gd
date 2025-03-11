class_name Serialisable
extends Node2D

func get_unique_id() -> String:
	if not has_meta("unique_id"):
		set_meta("unique_id", str(get_instance_id()))
	
	return get_meta("unique_id")

func serialise() -> Dictionary:
	return {
		"unique_id": get_unique_id(),
		"scene_path": get_scene_file_path(),
		"position": {
			"x": position.x,
			"y": position.y
		},
		"rotation": rotation,
		"scale": {
			"x": scale.x,
			"y": scale.y
		}
	}

func deserialise(data: Dictionary) -> void:
	if data.has("position"):
		position = Vector2(data["position"]["x"], data["position"]["y"])
	if data.has("rotation"):
		rotation = data["rotation"]
	if data.has("scale"):
		scale = Vector2(data["scale"]["x"], data["scale"]["y"])
