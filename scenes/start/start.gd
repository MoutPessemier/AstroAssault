extends Control

func _ready() -> void:
	DataManager.load_game()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://scenes/world/world.tscn")
