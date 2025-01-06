class_name SfxComponent
extends Node

@export var sound_effect: Resource

var sfx_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()

signal sfx_done_playing

func _ready() -> void:
	add_child(sfx_player)
	sfx_player.stream = sound_effect

func play_sfx():
	sfx_player.play()
	await sfx_player.finished
	sfx_done_playing.emit()

func set_volume(volume: float):
	sfx_player.volume_db = volume
