extends "res://Scenes/GameObjects/Objects/object.gd"

func _ready():
	type = Constants.OBJECTS.COFFEE_BEAN
	function_type = Global.swap_dict[type]
	function = Global.FUNCTION_DICT[function_type]
	object_type = function.function_type
	self.state = Constants.OBJECT_STATES.DEFAULT

# enum OBJECT_STATES {BREWED, CHOPPED, BREWING, DEFAULT, SANDWICH_BREAD
func _set_state(value):
	if state != value:
		state = value
	else:
		return
	#$Sandwich_Lower.visible = false
	match state:
		Constants.OBJECT_STATES.DEFAULT:
			$Sprite2D.frame = 0
		Constants.OBJECT_STATES.BREWED:
			$Sprite2D.frame = 2
		Constants.OBJECT_STATES.CHOPPED:
			$Sprite2D.frame = 1
		Constants.OBJECT_STATES.IN_CUP:
			$Sprite2D.frame = 3
		Constants.OBJECT_STATES.SANDWICH_BREAD:
			$Sprite2D.frame = 4
			#$Sandwich_Lower.visible = true
