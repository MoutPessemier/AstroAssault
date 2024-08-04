extends Node2D
@export var move_component: MoveComponent
@export var scale_component: ScaleComponent
@export var health_component: HealthComponent
@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D
@export var flash_component: FlashComponent
@export var shake_component: ShakeComponent
@export var hurtbox_component: HurtboxComponent
@export var hitbox_component: HitboxComponent

func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(queue_free)
	hurtbox_component.hurt.connect(func(hitbox: HitboxComponent):
		scale_component.tween_scale()
		flash_component.flash()
		#shake_component.tween_shake()
	)
	health_component.death.connect(queue_free)
