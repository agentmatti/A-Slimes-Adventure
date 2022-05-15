extends "res://players/Actors/actor.gd"

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -enemy1_speed.x

func _on_stompDetector_body_entered(body: PhysicsBody2D) -> void:
	if body.global_position.y > get_node("stompDetector").global_position.y:
		return
	get_node("CollisionShape2D").disabled = true
	queue_free()
	
func _physics_process(delta: float) -> void:
	_velocity.y = _velocity.y + gravity * delta
	if is_on_wall():
		_velocity.x = _velocity.x * -1.0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

