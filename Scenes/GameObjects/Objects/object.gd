extends Node2D

# everything inherits from this node
# sprites + function
# function is a class. separate from sprite.

var function : Function
@export var function_type = Constants.OBJECTS.LETTUCE
@export var object_type = Constants.OBJECT_TYPES.INGREDIENT
@export var type = Constants.OBJECTS.LETTUCE
@export var state = Constants.OBJECT_STATES.DEFAULT : set = _set_state
var contents # keurig only

# enum OBJECT_STATES {BREWED, CHOPPED, BREWING, DEFAULT, SANDWICH_BREAD
# rewritten in each inherited scene
func _set_state(value):
	pass
