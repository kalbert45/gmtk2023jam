extends CharacterBody2D

const SPEED = 100

enum ORIENTATIONS {RIGHT, LEFT, UP, DOWN}

var active = true : set = set_active
var doing = false
#var release_active = true
var direction = Vector2.ZERO

var held_object = null

@onready var _anim_player = $AnimationPlayer
@onready var interact_area = $InteractArea
@onready var interact_area_shape = $InteractArea/CollisionShape2D

func set_active(value):
	active = value
	if !active:
		direction = Vector2.ZERO
#	else:
#		release_active = false

func _unhandled_input(event):
	if !active:
		return
	
	if event.is_action_pressed("interact"):
		var areas = interact_area.get_overlapping_areas()
		if !areas.is_empty():
			var counter = areas[0].get_node(areas[0].node_path)
			# counter.interact returns an action
			do_something(counter, counter.interact())
	
# player does something
func do_something(counter, action):
	match action:
		Constants.PLAYER_ACTIONS.NOTHING:
			pass
		Constants.PLAYER_ACTIONS.CHOP:
			pass
		Constants.PLAYER_ACTIONS.BREW:
			pass
		Constants.PLAYER_ACTIONS.PICK_UP:
			if held_object:
				return
			if !counter.object:
				return
			
			var new_object = counter.pick_up()
			$Sort/HeldObject.add_child(new_object)
			held_object = new_object
		Constants.PLAYER_ACTIONS.PLACE:
			if !held_object:
				return
			if counter.object:
				return
				
			$Sort/HeldObject.remove_child(held_object)
			counter.place(held_object)
			held_object = null
				
			

func _physics_process(delta):
	# handle player input
	if active:
		direction = Vector2.ZERO
		if Input.is_action_pressed("move_down") != Input.is_action_pressed("move_up"):
			if Input.is_action_pressed("move_down"):
				direction.y = 1
			else:
				direction.y = -1
		
		if Input.is_action_pressed("move_left") != Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("move_left"):
				direction.x = -1
			else:
				direction.x = 1
	
	
	direction.x = clamp(direction.x, -1, 1)
	direction.y = clamp(direction.y, -1, 1)
	var new_dir = direction.normalized()
	
	velocity = Vector2(new_dir.x, new_dir.y) * SPEED
	move_and_slide()
	
	if (new_dir.x == 0) and (new_dir.y == 0):
		_anim_player.walking = false
	else:
		_anim_player.current_orientation = find_orientation(new_dir)
		_anim_player.walking = true
		
func find_orientation(dir):
	if dir.y > 0:
		interact_area_shape.position = Vector2(0,15)
		return _anim_player.ORIENTATIONS.DOWN
	elif dir.y < 0:
		interact_area_shape.position = Vector2(0,-6)
		return _anim_player.ORIENTATIONS.UP
	elif dir.x > 0:
		interact_area_shape.position = Vector2(15,0)
		return _anim_player.ORIENTATIONS.RIGHT
	else:
		interact_area_shape.position = Vector2(-15,0)
		return _anim_player.ORIENTATIONS.LEFT
