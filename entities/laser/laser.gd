extends Node2D

@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D
@export var scale_component: ScaleComponent
@export var flash_component: FlashComponent
@export var hitbox_component: HitboxComponent

func _ready() -> void:
	scale_component.tween_scale()
	flash_component.flash()
	visible_on_screen_notifier.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(queue_free.unbind(1))
