extends Node2D

var object = null

# returns a player action. Action depends
func interact(player):
	if object:
		match object.object_type:
			Constants.OBJECT_TYPES.COMBINATION:
				if player.held_object and player.held_object.object_type == Constants.OBJECT_TYPES.TOOL:
					if object.is_choppable():
						return Constants.PLAYER_ACTIONS.CHOP
					else:
						return Constants.PLAYER_ACTIONS.NOTHING
				if player.held_object:
					return Constants.PLAYER_ACTIONS.PLACE
				else:
					return Constants.PLAYER_ACTIONS.PICK_UP
			Constants.OBJECT_TYPES.TOOL:
				return Constants.PLAYER_ACTIONS.PICK_UP
			Constants.OBJECT_TYPES.DEVICE:
				return Constants.PLAYER_ACTIONS.BREW
	else:
		return Constants.PLAYER_ACTIONS.PLACE

# check if combo is viable. return true or false
func place(new_object):
	# check if combo is viable
	if object:
		var viable = object.check_combo(new_object)
		if !viable:
			return false
		else:
			object.add_combo(new_object)
			return true
	else:
		object = new_object
		add_child(object)
		return true
	
func pick_up():
	if object:
		remove_child(object)
		var new_object = object
		object = null
		return new_object
		
# place object and make it brewed state
func brew(new_object):
	var brewed_object = new_object.ingredients[0]
	new_object.remove_child(brewed_object)
	new_object.queue_free()
	object.add_child(brewed_object)
	brewed_object.state = Constants.OBJECT_STATES.BREWED
	object.contents = brewed_object
