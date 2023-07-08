extends Node2D

var object = null

# returns a player action. Action depends
func interact():
	if object:
		return Constants.PLAYER_ACTIONS.PICK_UP
	else:
		return Constants.PLAYER_ACTIONS.PLACE

func place(new_object):
	object = new_object
	add_child(object)
	
func pick_up():
	if object:
		remove_child(object)
		var new_object = object
		object = null
		return new_object
