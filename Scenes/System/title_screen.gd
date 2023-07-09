extends Control

func _ready():
	await get_tree().create_timer(1.0).timeout
	Bgm.play_song('boba_intro.ogg')


func _on_button_pressed():
	Bgm.fade_out()
	$Button.disabled = true
	TransitionHandler.transition(self, load('res://Scenes/System/main.tscn').instantiate())
