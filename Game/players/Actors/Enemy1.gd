extends "res://players/Actors/actor.gd"

onready var Label: Label = get_node("Label")

export var lives: = 2.0

var stillalive: = 1

var player = null

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -enemy1_speed.x

#func _on_stompDetector_body_entered(body: PhysicsBody2D) -> void:
#	if body.global_position.y > get_node("stompDetector").global_position.y:
#		return
#	lives = lives - 1
#
#	$AnimationPlayer.play("damage")
#
func still_alive():
	if lives == 0 or lives < 0:
		stillalive = 0
		$AnimationPlayer.play("ded")
		lives = 0

func _physics_process(delta: float) -> void:
	still_alive()
	Label.text = str(lives)
	_velocity.y = _velocity.y + gravity * delta * stillalive
	if is_on_wall():
		_velocity.x = _velocity.x * -1.0 * stillalive
	_move_to_player()
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y

func _move_to_player():
	if player:
		_velocity.x = position.direction_to(player.position).x * enemy1_speed.x
	else:
		pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body

func _on_Area2D_body_exited(body):
	player = null

func _on_Dash_detector_body_entered(body: KinematicBody2D):
	if body.name == "Player" and body.dash.is_dashing():
		lives = lives - 0.5
	else:
		pass


func get_slashed(lives: int):
	lives =- 1.0
