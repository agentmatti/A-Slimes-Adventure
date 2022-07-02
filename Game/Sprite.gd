extends Sprite

func ready():
	$Tween.interpolate_property(self,"modulate:a", 1.0, 0.0, 0.5, 3, 1)
	$Tween.start()
	

func _on_Tween_tween_completed():
	queue_free()
