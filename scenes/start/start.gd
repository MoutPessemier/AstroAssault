extends Control

func _ready() -> void:
	DataManager.load_game()

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		NavigationManager.navigate("res://scenes/world/world.tscn")
