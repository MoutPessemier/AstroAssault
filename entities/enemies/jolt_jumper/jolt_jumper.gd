class_name JoltJumper
extends Enemy

@export var animated_sprite: AnimatedSprite2D
@export var border_bounce_component: BorderBounceComponent
@export var collision_box: Area2D
@export var tongue_spawn_point: Marker2D

enum State { IDLE, JUMPING, ATTACKING }
enum TonguePosition { IN, EXTENDING, OUT, RETRACTING }

const STATE_DELAY := 1.0

var state: State: set = set_state
var tongue_position: TonguePosition: set = set_tongue_position
var jump_direction: int
var random: RandomNumberGenerator
var state_timer: float

var tongue_tip_scene = preload("res://entities/enemies/jolt_jumper/tongue_tip.tscn")
var tongue_body_scene = preload("res://entities/enemies/jolt_jumper/tongue_body.tscn")
var tongue_stack: Array

func _ready() -> void:
	super._ready()
	state = State.IDLE
	tongue_position = TonguePosition.IN
	random = RandomNumberGenerator.new()
	random.randomize()
	tongue_stack = []
	border_bounce_component.bounced.connect(func(direction: int):
		jump_direction = direction
	)
	# THIS IS ONLY AS A FALLBACK, SINCE IT ISN'T THE CLEANEST
	collision_box.area_entered.connect(_on_collision_box_entered)

func _process(delta: float) -> void:
	if state == State.IDLE:
		animated_sprite.play("idle")
		state_timer += delta
		if state_timer >= STATE_DELAY:
			state_timer = 0
			state = State.JUMPING
	
	if state == State.JUMPING:
		animated_sprite.play("jumping")
		state_timer += delta
		if state_timer >= STATE_DELAY:
			state_timer = 0
			if global_position.y >= Constants.SHIP_Y_POSITION - 8:
				state = State.IDLE
			else:
				state = State.ATTACKING
	
	if state == State.ATTACKING:
		if not animated_sprite.is_playing():
			animated_sprite.play("attack_start")

func _physics_process(_delta: float) -> void:
	if state == State.IDLE:
		_reset_move_stats()
	
	if state == State.JUMPING:
		_update_move_stats()
	
	if state == State.ATTACKING:
		_reset_move_stats()

func _reset_move_stats():
	move_component.velocity =  Vector2.ZERO

func _update_move_stats():
	move_component.velocity = Vector2(random.randi_range(35,45) * jump_direction, random.randi_range(35,45))

func _generate_random_jump_direction() -> int:
	var value = random.randf()
	if value < 0.5:
		return -1
	else:
		return 1

func set_state(new_state: State):
	state = new_state
	match state:
		State.IDLE:
			tongue_position = TonguePosition.IN
			pass
		State.JUMPING:
			tongue_position = TonguePosition.IN
			jump_direction = _generate_random_jump_direction()
		State.ATTACKING:
			attack()

func _on_collision_box_entered(area_2d: Area2D) -> void:
	if area_2d.get_parent() is JoltJumper:
		var other_jolt_jumper = area_2d.get_parent() as JoltJumper
		_bounce_away_from(other_jolt_jumper)

func _bounce_away_from(other_jumper: JoltJumper):
	var push_dir = (global_position - other_jumper.global_position).normalized()
	var speed = move_component.velocity.length()
	move_component.velocity = push_dir * speed
	var separation_distance = 4.0
	global_position += push_dir * separation_distance

func render_tongue() -> void:
	for i in tongue_stack.size():
		var scene = tongue_stack[i]
		
		if not is_instance_valid(scene):
			continue
		
		if not scene.is_inside_tree():
			add_child(scene)
		
		scene.global_position = tongue_spawn_point.global_position + Vector2(0, i * Constants.TONGUE_BODY_HEIGHT)

func shoot_out_tongue() -> void:
	if not tongue_position == TonguePosition.IN:
		return
	
	tongue_position = TonguePosition.EXTENDING
	var current_length = 0
	var tongue_tip = tongue_tip_scene.instantiate()
	tongue_stack.push_back(tongue_tip)
	render_tongue()
	await get_tree().create_timer(0.015).timeout
	
	while tongue_spawn_point.global_position.y + current_length < 216 + Constants.TONGUE_BODY_HEIGHT * 3:
		if not is_inside_tree():
			return
	
		if get_tree().paused:
			await get_tree().process_frame
			continue
		
		current_length += Constants.TONGUE_BODY_HEIGHT
		var tongue_body = tongue_body_scene.instantiate()
		tongue_stack.push_front(tongue_body)
		render_tongue()
		await get_tree().create_timer(0.015).timeout
	
	tongue_position = TonguePosition.OUT
	# TODO: FOR DEBUGGING, REMOVE AFTER
	await get_tree().create_timer(0.5).timeout

func retract_tongue() -> void:
	if not tongue_position == TonguePosition.OUT:
		return
	
	tongue_position = TonguePosition.RETRACTING
	while not tongue_stack.is_empty():
		if not is_inside_tree():
			return
		
		if get_tree().paused:
			await get_tree().process_frame
			continue
		
		var tongue_part = tongue_stack.pop_front()
		
		if not is_instance_valid(tongue_part):
			continue
		
		if tongue_part.is_inside_tree():
			tongue_part.queue_free()
		render_tongue()
		await get_tree().create_timer(0.015).timeout
	
	tongue_position = TonguePosition.IN

# Issues: 
# - The tongue is serialised, but not positioned back correctly 
# - The animation keeps on playing, even though I put it to a stop programatically and the animation loop is turned off
# - The tongue is like a death ray, dealing constant damage, I want the tongue to deal damage, and then be turned off for a while (I want the player to have no vulnerability for a while of the same tongue, but not from any other damage source)

func attack() -> void:	
	animated_sprite.play("attack_start")
	await animated_sprite.animation_finished
	
	await shoot_out_tongue()
	await retract_tongue()
	
	animated_sprite.play("attack_end")
	await animated_sprite.animation_finished
	
	state = State.IDLE

func serialise() -> Dictionary:
	var data = super.serialise()
	
	data["state"] = state
	data["tongue_position"] = tongue_position
	data["jump_direction"] = jump_direction
	data["tongue_stack"] = tongue_stack

	return data

func deserialise(data: Dictionary) -> void:
	super.deserialise(data)
	
	if data.has("state"):
		state = data["state"]
	
	if data.has("tongue_position"):
		tongue_position = data["tongue_position"]
	
	if data.has("jump_direction"):
		jump_direction = data["jump_direction"]

	if data.has("tongue_stack"):
		tongue_stack = data["tongue_stack"]
		render_tongue()

# TODO: FOR DEBUGGING, REMOVE AFTER
@onready var label: Label = $Label
func set_tongue_position(new_position: TonguePosition):
	label.text = parse_enum(new_position)
	tongue_position = new_position

func parse_enum(number: int) -> String:
	match number:
		0: return "IN"
		1: return "EXTENDING"
		2: return "OUT"
		3: return "RETRACTING"
		_: return ""
