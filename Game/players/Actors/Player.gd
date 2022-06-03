extends Actor
export var stomp_impulse: = 500.0

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

# warning-ignore:unused_argument
func _on_EnemyDetector_area_entered(area: Area2D) -> void:
	_velocity = calculate_stomp_velocity(_velocity, stomp_impulse)

# warning-ignore:unused_argument
func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	queue_free()

# warning-ignore:unused_argument
func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_pressed("stomp") and _velocity.y < 0.0
	var direction: = get_direction()
	looking_direction()
	_velocity = calculate_move_velocity(_velocity, direction, player_speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
func animation_update():
	anim_player.play("Idle")

func looking_direction():
	if Input.is_action_pressed("move_right") == true:
		get_node("Sprite").set_flip_h(false)
	elif Input.is_action_pressed("move_left") == true:
		get_node("Sprite").set_flip_h(true)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 0.0
	)
	

func calculate_move_velocity(
		linear_velocity: Vector2,
		player_speed: Vector2,
		direction: Vector2,
		is_jump_interruptet: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = player_speed.x * direction.x
	out.y = out.y + (gravity * get_physics_process_delta_time())
	if direction.y == -1.0:
		out.y = player_speed.y * direction.y
	if is_jump_interruptet:
		out.y = 0.0
	return out

func calculate_stomp_velocity(linear_velocity: Vector2, impulse: float) -> Vector2:
	var out: = linear_velocity
	out.y = -impulse
	return out


