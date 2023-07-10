extends Control

func _ready():
	$Label.text = 'Day ' + str(Global.day)

func _on_button_pressed():
	$Button.disabled = true
	Global.reset()
	TransitionHandler.transition(self, load('res://Scenes/System/main.tscn').instantiate())
