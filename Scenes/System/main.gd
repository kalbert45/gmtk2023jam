extends Node2D

var game_over = false

# if day == 1, play intro. otherwise start the day
func _ready():
	$DayLabel.text = str(Global.day)
	SignalBus.end_day.connect(_on_end_day)
	SignalBus.new_day.connect(_on_new_day)
	SignalBus.game_over.connect(_on_game_over)
	
	if Global.first:
		Global.first = false
		$Sort/Player.active = false
		# add tutorial note
		add_child(load('res://Scenes/System/tutorial_note.tscn').instantiate())
	
	#Global.swap_functions(Constants.OBJECTS.CUCUMBER, Constants.OBJECTS.COFFEE_BEAN)

func _on_new_day():
	$Sort/Player.active = true
	$DayHandler.start()

# deactivate player, 
func _on_end_day():
	if game_over:
		return
	
	Global.day += 1
	$Sort/Player.active = false
	TransitionHandler.transition(self, load('res://Scenes/System/reverse_scene.tscn').instantiate())

func _on_game_over():
	game_over = true
	$Sort/Player.active = false
	# fade out bgm
	await get_tree().create_timer(1.5).timeout
	# transition to game over screen
	TransitionHandler.transition(self, load('res://Scenes/System/game_over_screen.tscn').instantiate())

func _on_animation_player_animation_finished(anim_name):
	pass # Replace with function body.
