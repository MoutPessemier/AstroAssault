extends Environments

@export var HEALTH_POWER_UP_SCENE: PackedScene
@export var SHIELD_POWER_UP_SCENE: PackedScene
@export var SPEED_POWER_UP_SCENE: PackedScene
@export var spawner_component: SpawnerComponent
@export var hurtbox_component: HurtboxComponent
@export var flash_component: FlashComponent
@export var scale_component: ScaleComponent
@export var shake_component: ShakeComponent

func _ready() -> void:
	health_component.death.connect(destory_ship)
	hurtbox_component.hurt.connect(func(_hitbox: HitboxComponent):
		scale_component.tween_scale()
		flash_component.flash()
		shake_component.tween_shake()
	)

func destory_ship() -> void:
	var random_power_up = _generate_random_powerup()
	handle_spawn(random_power_up)
	queue_free()

func _generate_random_powerup() -> PackedScene:
	var random_number = RandomNumberGenerator.new().randf()
	if random_number <= 0.33:
		return HEALTH_POWER_UP_SCENE
	elif random_number <= 0.66:
		return SHIELD_POWER_UP_SCENE
	else:
		return SPEED_POWER_UP_SCENE

func handle_spawn(power_up_scene: PackedScene) -> void:
	spawner_component.scene = power_up_scene
	spawner_component.call_deferred("spawn", global_position)
