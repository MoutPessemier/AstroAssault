class_name HitboxComponent
extends Area2D

@export var damage: int = 1

signal hit_hurtbox(hurtbox)

func _ready():
	area_entered.connect(_on_hurtbox_entered)

func _on_hurtbox_entered(hurtbox: HurtboxComponent):
	if not hurtbox is HurtboxComponent: return
	if hurtbox.is_invincible: return
	hit_hurtbox.emit(hurtbox)
	hurtbox.hurt.emit(self)
