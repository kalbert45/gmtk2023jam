extends Node2D

@export var object_type = Constants.OBJECTS.LETTUCE
var object = null

func _ready():
	match object_type:
		Constants.OBJECTS.LETTUCE:
			object = load('res://Scenes/GameObjects/Objects/lettuce.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_lettuce.png')
		Constants.OBJECTS.TOMATO:
			object = load('res://Scenes/GameObjects/Objects/tomato.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_tomato.png')
		Constants.OBJECTS.BREAD:
			object = load('res://Scenes/GameObjects/Objects/bread.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_bread.png')
		Constants.OBJECTS.COFFEE_BEAN:
			object = load('res://Scenes/GameObjects/Objects/coffee_bean.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_coffeebean.png')
		Constants.OBJECTS.CUCUMBER:
			object = load('res://Scenes/GameObjects/Objects/cucumber.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_cucumber.png')
		Constants.OBJECTS.CUP:
			object = load('res://Scenes/GameObjects/Objects/cup.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_cup.png')
		Constants.OBJECTS.KEURIG:
			object = load('res://Scenes/GameObjects/Objects/keurig.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_keurig.png')
		Constants.OBJECTS.KNIFE:
			object = load('res://Scenes/GameObjects/Objects/knife.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_knife.png')
		# probably temporary
		Constants.OBJECTS.PLATE:
			object = load('res://Scenes/GameObjects/Objects/plate.tscn')
			$Sprite2D/IngredientPic.texture = load('res://Assets/Sprites/Objects/basic_plate.png')

# returns a player action. Action depends
func interact(_player):
	return Constants.PLAYER_ACTIONS.PICK_UP

func place(_object):
	pass
	
# return instantiated object
func pick_up():
	Global.play_sfx('open_crate.wav', -5, true, Vector2(0.6, 1.0))
	var inst = object.instantiate()
	add_child(inst)
	if (inst.object_type == Constants.OBJECT_TYPES.INGREDIENT) or (inst.object_type == Constants.OBJECT_TYPES.PLATE):
		var new_object = load('res://Scenes/GameObjects/Objects/combo.tscn').instantiate()
		remove_child(inst)
		new_object.add_ingredient(inst)
		return new_object
	else:
		remove_child(inst)
		return inst
