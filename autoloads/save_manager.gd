extends Node

var _temp_game_state = null
var _restore_on_next_frame = false

func save_game_state() -> void:
	_temp_game_state = serialise_world()

func schedule_state_restoration() -> void:
	_restore_on_next_frame = true

func _process(_delta: float) -> void:
	if _restore_on_next_frame:
		_restore_on_next_frame = false
		restore_game_state()

func restore_game_state() -> void:
	var state = _temp_game_state
	_temp_game_state = null
	print(state)
	if state:
		deserialise_world(state)

func serialise_world() -> Dictionary:
	var state = {
		"metadata": {
			"timestamp": Time.get_unix_time_from_system()
		},
		"entities": []
	}
	var serialisable_nodes = get_serialisable_nodes()
	
	for node in serialisable_nodes:
		var entity_data = node.serialise()
		if entity_data:
			state["entities"].append(entity_data)
	
	return state

func get_serialisable_nodes() ->  Array:
	var world = get_tree().current_scene
	var serialisables = []
	var nodes = world.find_children("*", "", true, false)
	
	for node in nodes:
		if node.has_method("serialise"):
			serialisables.append(node)
	
	return serialisables

func deserialise_world(state: Dictionary) -> void:
	var nodes = get_serialisable_nodes()
	var persisted_ids = []
	
	for entity_data in state["entities"]:
		persisted_ids.append(entity_data["unique_id"])
	
	for node in nodes:
		if node.has_method("get_unique_id"):
			var id = node.get_unique_id()
			if not id in persisted_ids:
				node.queue_free()
	
	for entity_data in state["entities"]:
		var existing_node = find_node_by_id(entity_data["unique_id"])
		if existing_node and existing_node.has_method("deserialise"):
			existing_node.deserialise(entity_data)
		else:
			spawn_entity(entity_data)

func find_node_by_id(unique_id: String) -> Node:
	var nodes = get_serialisable_nodes()
	for node in nodes:
		if node.has_method("get_unique_id") and node.get_unique_id() == unique_id:
			return node
	
	return null

func spawn_entity(entity_data: Dictionary) -> Node:
	var world = get_tree().current_scene
	var scene_path = entity_data["scene_path"]
	var scene = load(scene_path)
	
	if not scene:
		printerr("Failed to load scene: ", scene_path)
		return null
	
	var instance = scene.instantiate()
	world.add_child(instance)
	
	if instance.has_method("deserialise"):
		instance.deserialise(entity_data)
	
	return instance
