extends "res://Scenes/GameObjects/Objects/object.gd"

func _ready():
	type = Constants.OBJECTS.LETTUCE
	function_type = Global.swap_dict[type]
	function = Global.FUNCTION_DICT[function_type]

# enum OBJECT_STATES {BREWED, CHOPPED, BREWING, DEFAULT, SANDWICH_BREAD
func _set_state(value):
	state = value
	
	match state:
		Constants.OBJECT_STATES.DEFAULT:
			pass
		Constants.OBJECT_STATES.BREWED:
			pass
		Constants.OBJECT_STATES.CHOPPED:
			pass
		Constants.OBJECT_STATES.BREWING:
			pass
		Constants.OBJECT_STATES.SANDWICH_BREAD:
			pass
