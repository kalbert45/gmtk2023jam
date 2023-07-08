extends Node

const SFX_SCENE = preload('res://Scenes/System/sfx.tscn')

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

# General sfx player
func play_sfx(path, _random=null, _range=null):
	var s = load('res://Assets/Sounds/SFX/' + path)
	var sfx = SFX_SCENE.instantiate()
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
