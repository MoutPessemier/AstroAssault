class_name Environments
extends Node2D

@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D
@export var hitbox_component: HitboxComponent
@export var destroyed_component: DestroyedComponent

func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))
