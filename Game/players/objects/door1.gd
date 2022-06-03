tool
extends Area2D

onready var anim_player: AnimationPlayer = $AnimationPlayer # the $(shift+4=$) replaces/ is the same as get_node()

export var next_scene: PackedScene


func _on_body_entered(body):
	teleport()

func _get_configuration_warning() -> String:
	return "U forgot to add next scene dumbass" if not next_scene else ""
	
func teleport() -> void:
	anim_player.play("fadein")
	yield(anim_player, "animation_finished") # waits for the animation to be finished
	get_tree().change_scene_to(next_scene)


