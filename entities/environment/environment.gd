class_name Environments
extends Serialisable

@export var visible_on_screen_notifier: VisibleOnScreenNotifier2D
@export var hitbox_component: HitboxComponent
@export var destroyed_component: DestroyedComponent
@export var health_component: HealthComponent

func _ready() -> void:
	visible_on_screen_notifier.screen_exited.connect(queue_free)
	hitbox_component.hit_hurtbox.connect(destroyed_component.destroy.unbind(1))

func serialise() -> Dictionary:
	var data = super.serialise()
	data["health"] = health_component.health
	
	return data

func deserialise(data: Dictionary) -> void:
	super.deserialise(data)
	if data.has("health"):
		health_component.health = data["health"]
