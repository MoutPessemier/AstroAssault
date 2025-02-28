class_name SfxComponent
extends AudioStreamPlayer

@export var min_pitch: float = 0.6
@export var max_pitch: float = 1.2

func _init() -> void:
	set_bus("SoundEffects")
	mix_target = AudioStreamPlayer.MIX_TARGET_STEREO

func play_sfx():
	pitch_scale = randf_range(min_pitch, max_pitch)
	play()
