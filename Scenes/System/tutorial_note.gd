extends CanvasLayer




func _on_texture_button_pressed():
	$TextureRect/TextureButton.disabled = true
	$AnimationPlayer.play("fade_out")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == 'fade_in':
		$TextureRect/TextureButton.disabled = false
	if anim_name == 'fade_out':
		SignalBus.emit_signal('new_day')
		queue_free()
