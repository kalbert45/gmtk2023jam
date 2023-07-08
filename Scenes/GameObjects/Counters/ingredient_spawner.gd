extends Node2D

@export var object_type = Constants.OBJECTS.LETTUCE
var object = null

func _ready():
	match object_type:
		Constants.OBJECTS.LETTUCE:
			object = load('res://Scenes/GameObjects/Objects/lettuce.tscn').instantiate()

# returns a player action. Action depends
func interact():
	return Constants.PLAYER_ACTIONS.PICK_UP

func place(_object):
	pass
	
# return instantiated object
func pick_up():
	var new_object = object
	object = load('res://Scenes/GameObjects/Objects/lettuce.tscn').instantiate()
	return new_object
