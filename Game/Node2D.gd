extends Node2D

export var dash_delay = 0.1

onready var duration_timer = $DurationTimer

var can_dash = true
var is_dashing = false

func start_dash(duration):
	is_dashing = true
	duration_timer.wait_time = duration
	duration_timer.start()
	


func is_dashing():
	return !duration_timer.is_stopped()


func end_dash():
	is_dashing = false
	can_dash = false
	yield(get_tree().create_timer(dash_delay), 'timeout')
	can_dash = true


func _on_DurationTimer_timeout():
	end_dash()
