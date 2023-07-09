extends Node

const SFX_SCENE = preload('res://Scenes/System/sfx.tscn')

# keep track of which day it is
var first = true # used for tutorial note
var day = 1
var lives = 3 : set = _set_life
var prev_rev = [null, null] # to prevent same reverse

# dictionary to keep track of whats actually what
var swap_dict = {Constants.OBJECTS.BREAD : Constants.OBJECTS.BREAD,
Constants.OBJECTS.COFFEE_BEAN : Constants.OBJECTS.COFFEE_BEAN,
Constants.OBJECTS.CUCUMBER : Constants.OBJECTS.CUCUMBER,
Constants.OBJECTS.CUP : Constants.OBJECTS.CUP,
Constants.OBJECTS.KEURIG : Constants.OBJECTS.KEURIG,
Constants.OBJECTS.KNIFE : Constants.OBJECTS.KNIFE,
Constants.OBJECTS.LETTUCE : Constants.OBJECTS.LETTUCE,
Constants.OBJECTS.PLATE : Constants.OBJECTS.PLATE,
Constants.OBJECTS.TOMATO : Constants.OBJECTS.TOMATO}

# used to generate recipes
var swap_dict_rev = swap_dict.duplicate()

# used to reset game
var RESET_DICT = swap_dict.duplicate()

# dictionary to map object const -> function
var FUNCTION_DICT = {Constants.OBJECTS.BREAD : preload('res://Resources/Functions/Bread.tres'),
Constants.OBJECTS.COFFEE_BEAN : preload('res://Resources/Functions/Coffee_Bean.tres'),
Constants.OBJECTS.CUCUMBER : preload('res://Resources/Functions/Cucumber.tres'),
Constants.OBJECTS.CUP : preload('res://Resources/Functions/Cup.tres'),
Constants.OBJECTS.KEURIG : preload('res://Resources/Functions/Keurig.tres'),
Constants.OBJECTS.KNIFE : preload('res://Resources/Functions/Knife.tres'),
Constants.OBJECTS.LETTUCE : preload('res://Resources/Functions/Lettuce.tres'),
Constants.OBJECTS.PLATE : preload('res://Resources/Functions/Plate.tres'),
Constants.OBJECTS.TOMATO : preload('res://Resources/Functions/Tomato.tres')}

var RECIPE_DICT = {
	Constants.RECIPES.SIMPLE_SALAD : preload("res://Resources/Recipes/simple_salad.tscn"),
	Constants.RECIPES.SALAD : preload("res://Resources/Recipes/salad.tscn"),
	Constants.RECIPES.COFFEE : preload("res://Resources/Recipes/coffee.tscn"),
	Constants.RECIPES.SANDWICH : preload("res://Resources/Recipes/sandwich.tscn")
}

# General sfx player
func play_sfx(path, _db = null, _random=null, _range=null):
	var s = load('res://Assets/Sounds/SFX/' + path)
	var sfx = SFX_SCENE.instantiate()
	if _db:
		sfx.volume_db = _db
	if _random:
		sfx.random = _random
	if _range:
		sfx.range = _range
	sfx.stream = s
	add_child(sfx)
	
func swap_functions(a, b):
	var holder = swap_dict[a]
	swap_dict[a] = swap_dict[b]
	swap_dict[b] = holder
	
	swap_dict_rev[swap_dict[a]] = a
	swap_dict_rev[swap_dict[b]] = b
	
func reset():
	day = 1
	self.lives = 3
	swap_dict = RESET_DICT.duplicate()
	swap_dict_rev = RESET_DICT.duplicate()
	
func _set_life(value):
	if value < lives:
		lives = value
		SignalBus.emit_signal('lose_life')
	else:
		lives = value
	
	if lives == 0:
		SignalBus.emit_signal('game_over')
	
