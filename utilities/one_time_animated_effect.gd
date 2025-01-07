class_name OnetimeAnimatedEffect
extends AnimatedSprite2D

@export var sfx_component: SfxComponent

func _ready() -> void:
	animation_finished.connect(queue_free)
	animation_looped.connect(queue_free)
	sfx_component.play_sfx()
