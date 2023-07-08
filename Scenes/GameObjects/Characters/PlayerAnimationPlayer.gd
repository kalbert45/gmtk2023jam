extends AnimationPlayer

enum ORIENTATIONS {RIGHT, LEFT, UP, DOWN}

var walking = false : set = set_walking
var current_orientation = ORIENTATIONS.DOWN : set = set_orientation

func set_walking(value):
	if value == walking:
		return
		
	walking = value
	if walking:
		match current_orientation:
			ORIENTATIONS.DOWN:
				play("Front_walk")
			ORIENTATIONS.UP:
				play("Back_walk")
			ORIENTATIONS.RIGHT:
				play("Right_walk")
			ORIENTATIONS.LEFT:
				play("Left_walk")
	else:
		match current_orientation:
			ORIENTATIONS.DOWN:
				play("Front_Idle")
			ORIENTATIONS.UP:
				play("Back_Idle")
			ORIENTATIONS.RIGHT:
				assigned_animation = "Right_walk"
				seek(0.0, true)
				stop()
			ORIENTATIONS.LEFT:
				assigned_animation = "Left_walk"
				seek(0.0, true)
				stop()
				
func set_orientation(value):
	if value == current_orientation:
		return
		
	current_orientation = value
	
	if walking:
		match current_orientation:
			ORIENTATIONS.DOWN:
				play("Front_walk")
			ORIENTATIONS.UP:
				play("Back_walk")
			ORIENTATIONS.RIGHT:
				play("Right_walk")
			ORIENTATIONS.LEFT:
				play("Left_walk")
	else:
		match current_orientation:
			ORIENTATIONS.DOWN:
				play("Front_Idle")
			ORIENTATIONS.UP:
				play("Back_Idle")
			ORIENTATIONS.RIGHT:
				assigned_animation = "Right_walk"
				seek(0.0, true)
				stop()
			ORIENTATIONS.LEFT:
				assigned_animation = "Left_walk"
				seek(0.0, true)
				stop()
