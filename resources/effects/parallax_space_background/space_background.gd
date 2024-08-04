extends ParallaxBackground

@export var space_layer: ParallaxLayer
@export var far_stars_layer: ParallaxLayer
@export var close_stars_layer: ParallaxLayer

func _process(delta: float) -> void:
	space_layer.motion_offset.y += 2 * delta
	far_stars_layer.motion_offset.y += 5 * delta
	close_stars_layer.motion_offset.y += 10 * delta
