extends Node

var previous_scene: String = ""

func navigate(path: String):
	previous_scene = get_tree().current_scene.scene_file_path
	get_tree().change_scene_to_file(path)
