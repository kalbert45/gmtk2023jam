extends CanvasLayer

@onready var _anim_player = $AnimationPlayer

# fades out
# deletes from scene, adds to_scene to from_scene's parent
# fades in
func transition(from_scene, to_scene):
	_anim_player.play("fade_out")
	await _anim_player.animation_finished
	var new_parent = from_scene.get_parent()
	from_scene.call_deferred('free')
	new_parent.add_child(to_scene)
	await get_tree().create_timer(0.5).timeout
	_anim_player.play("fade_in")
