extends Node2D

# everything inherits from this node
# sprites + function
# function is a class. separate from sprite.

var function : Function
var function_type = Constants.OBJECTS.LETTUCE
var type = Constants.OBJECTS.LETTUCE
var state = Constants.OBJECT_STATES.DEFAULT : set = _set_state

# enum OBJECT_STATES {BREWED, CHOPPED, BREWING, DEFAULT, SANDWICH_BREAD
# rewritten in each inherited scene
func _set_state(value):
	pass
