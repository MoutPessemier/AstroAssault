class_name Shield
extends Node2D

@export var shield_sprite: AnimatedSprite2D
@export var hurtbox_component: HurtboxComponent

func _ready() -> void:
	#  TODO: figure out why it is not getting in the area_entered signal
	hurtbox_component.area_entered.connect(func(_area): 
		shield_sprite.play('hit')
	)
	_disable_area_2d()

func enable_for(duration: float) -> void:
	visible = true
	_enable_area_2d()
	await get_tree().create_timer(duration).timeout
	_disable_area_2d()
	visible = false

func _disable_area_2d() -> void:
	hurtbox_component.set_deferred("monitorable", false)
	hurtbox_component.set_deferred("monitoring", false)

func _enable_area_2d() -> void:
	hurtbox_component.set_deferred("monitorable", true)
	hurtbox_component.set_deferred("monitoring", true)
