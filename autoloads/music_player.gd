extends AudioStreamPlayer

var intro = preload("res://assets/music/intro.wav")
var body = preload("res://assets/music/body.wav")

func _ready() -> void:
	set_bus("Music")
	stream = intro
	playing = true
	finished.connect(_on_intro_finished_play_body)

func _on_intro_finished_play_body():
	stream = body
	playing = true
