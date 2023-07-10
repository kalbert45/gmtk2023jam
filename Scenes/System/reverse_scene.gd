extends Node2D


func _ready():
	randomize()
	reverse_random()
	
	await get_tree().create_timer(2.0).timeout
	$AnimationPlayer.play("swap")
	Global.play_sfx('impact.mp3')
	
	
# pick 2 random things to reverse. keep track of previous 2 to prevent repeat.
# once picked, set appropriate sprites
func reverse_random():
	var object_list = Global.swap_dict.keys()
	var A = object_list.pick_random()
	var B = object_list.pick_random()
	
	while (A == B) or ((A == Global.prev_rev[0]) and (B == Global.prev_rev[1])) or \
			((A == Global.prev_rev[1]) and (B == Global.prev_rev[0])):
		B = object_list.pick_random()
		
	set_sprite($ObjectA, A)
	set_sprite($ObjectB, B)
	
	Global.prev_rev[0] = A
	Global.prev_rev[1] = B
	
	Global.swap_functions(A, B)
		
func set_sprite(sprite_node, object_id):
	match object_id:
		Constants.OBJECTS.BREAD:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_bread.png")
		Constants.OBJECTS.COFFEE_BEAN:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_coffeebean.png")
		Constants.OBJECTS.CUCUMBER:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_cucumber.png")
		Constants.OBJECTS.CUP:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_cup.png")
		Constants.OBJECTS.KEURIG:
			sprite_node.texture = load("res://Assets/Sprites/Objects/new_keurig.png")
		Constants.OBJECTS.KNIFE:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_knife.png")
		Constants.OBJECTS.LETTUCE:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_lettuce.png")
		Constants.OBJECTS.PLATE:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_plate.png")
		Constants.OBJECTS.TOMATO:
			sprite_node.texture = load("res://Assets/Sprites/Objects/basic_tomato.png")


func _on_timer_timeout():
	$Button/AnimationPlayer.play("fade_in")


func _on_button_pressed():
	$Button.disabled = true
	TransitionHandler.transition(self, load('res://Scenes/System/main.tscn').instantiate())
