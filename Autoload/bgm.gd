extends AudioStreamPlayer

func fade_out():
	$AnimationPlayer.play("fade_out")
	
func play_song(song_path):
	var s = load('res://Assets/Sounds/Music/' + song_path)
	stream = s
	volume_db = 0
	play()

func mute():
	pass

func unmute():
	pass


func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		'fade_out':
			stop()
