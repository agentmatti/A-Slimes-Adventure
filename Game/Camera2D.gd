extends Camera2D

#variables 
#(are usable in every function)
# warning-ignore:unused_class_variable
var rotation_speed = PI
var speed = 400.0



#updates every frame
func _process(delta):
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	#rotate the player constantly
	rotation = rotation + (rotation_speed * direction * delta)




	#(only avilable for the next lones in this function)
	#move the player forward
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2.UP.rotated(rotation) * speed
	if Input.is_action_pressed("ui_down"):
		velocity = Vector2.DOWN.rotated(rotation) * speed
		

	position = position + (velocity * delta)

