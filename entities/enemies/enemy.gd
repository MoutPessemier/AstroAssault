class_name Enemy
extends Serialisable

@export var move_component: MoveComponent
@export var scale_component: ScaleComponent
@export var health_component: HealthComponent
@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D
@export var flash_component: FlashComponent
@export var shake_component: ShakeComponent
@export var hurtbox_component: HurtboxComponent
@export var hitbox_component: HitboxComponent
@export var destroyed_component: DestroyedComponent
@export var score_component: ScoreComponent
@export var score_loss: int

func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(func():
		score_component.adjust_score(-score_loss)
		queue_free()
	)
	hurtbox_component.hurt.connect(func(_hitbox: HitboxComponent):
		scale_component.tween_scale()
		flash_component.flash()
		shake_component.tween_shake()
	)
	health_component.death.connect(func():
		score_component.adjust_score()
	)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))

func serialise() -> Dictionary:
	var data = super.serialise()
	data["health"] = health_component.health
	
	return data

func deserialise(data: Dictionary) -> void:
	super.deserialise(data)
	if data.has("health"):
		health_component.health = data["health"]
