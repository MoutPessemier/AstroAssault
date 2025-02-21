extends Node

var previous_scene_path: String = ""
var was_paused: bool

func navigate(path: String, paused_state: bool = false):
	var current_scene = get_tree().current_scene
	was_paused = paused_state
	if current_scene:
		previous_scene_path = current_scene.scene_file_path
	else:
		print("Warning: current_scene is null!")
	get_tree().paused = false
	get_tree().change_scene_to_file(path)
