extends CharacterBody2D

const SPEED = 110
const DOING_SPEED = 60

signal action_complete

enum ORIENTATIONS {RIGHT, LEFT, UP, DOWN}

var active = true : set = set_active
var doing = false : set = set_doing
#var release_active = true
var direction = Vector2.ZERO

var held_object = null
var current_action
var current_counter

@onready var _anim_player = $AnimationPlayer
@onready var interact_area = $InteractArea
@onready var interact_area_shape = $InteractArea/CollisionShape2D

func _ready():
	action_complete.connect(_on_action_complete)

func set_active(value):
	active = value
	if !active:
		direction = Vector2.ZERO
#	else:
#		release_active = false

func set_doing(value):
	doing = value
	if doing:
		self.active = false
		$ActionProgress.value = 0
		$ActionProgress.modulate.a = 1
	else:
		self.active = true
		$ActionProgress/ProgressFade.play("fade_out")

func _unhandled_input(event):
	if event.is_action_released("interact"):
		if doing:
			self.doing = false
	
	if !active:
		return
	
	if event.is_action_pressed("interact"):
		var areas = interact_area.get_overlapping_areas()
		if !areas.is_empty():
			var counter = areas[0].get_node(areas[0].node_path)
			# counter.interact returns an action
			do_something(counter, counter.interact(self))
			
	
	
# player does something
func do_something(counter, action):
	match action:
		Constants.PLAYER_ACTIONS.NOTHING:
			pass
		# needs to be held action
		Constants.PLAYER_ACTIONS.CHOP:
			current_action = Constants.PLAYER_ACTIONS.CHOP
			current_counter = counter
			self.doing = true
		Constants.PLAYER_ACTIONS.BREW:
			if !held_object:
				return
			if held_object.object_type == Constants.OBJECT_TYPES.COMBINATION:
				if held_object.is_brewable():
					$Sort/HeldObject.remove_child(held_object)
					counter.brew(held_object)
					held_object = null
				elif held_object.is_cup():
					if counter.object.contents:
						current_action = Constants.PLAYER_ACTIONS.BREW
						current_counter = counter
						self.doing = true
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
			#if counter.object:
			#	return
			$Sort/HeldObject.remove_child(held_object)
			var success = counter.place(held_object)
			if success:
				held_object = null
			else:
				$Sort/HeldObject.add_child(held_object)
		Constants.PLAYER_ACTIONS.THROW_AWAY:
			if !held_object:
				return
			
			if held_object.object_type == Constants.OBJECT_TYPES.COMBINATION:
				held_object.clear()
				if held_object.ingredients.is_empty():
					held_object.queue_free()
					held_object = null
			else:
				held_object.queue_free()
				held_object = null
				
		Constants.PLAYER_ACTIONS.SERVE:
			if !held_object:
				return
				
			if held_object.object_type == Constants.OBJECT_TYPES.COMBINATION:
				var recipe = held_object.check_recipe()
				if recipe == Constants.RECIPES.NO_PLATE:
					return
				
				$Sort/HeldObject.remove_child(held_object)
				counter.serve(held_object)
				held_object = null
			

func _physics_process(delta):
	if doing:
		$ActionProgress.value = $ActionProgress.value + DOING_SPEED * delta
	
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
		$Sort/HeldObject.position = Vector2(0,-2)
		return _anim_player.ORIENTATIONS.DOWN
	elif dir.y < 0:
		interact_area_shape.position = Vector2(0,-15)
		$Sort/HeldObject.position = Vector2(0,-15)
		return _anim_player.ORIENTATIONS.UP
	elif dir.x > 0:
		interact_area_shape.position = Vector2(15,0)
		$Sort/HeldObject.position = Vector2(10,-11)
		return _anim_player.ORIENTATIONS.RIGHT
	else:
		interact_area_shape.position = Vector2(-15,0)
		$Sort/HeldObject.position = Vector2(-10,-11)
		return _anim_player.ORIENTATIONS.LEFT


func _on_action_progress_value_changed(value):
	$ActionProgress.value = value
	if value == $ActionProgress.max_value:
		$ActionProgress/Particles.emitting = true
		self.doing = false
		emit_signal("action_complete")

func _on_action_complete():
	match current_action:
		Constants.PLAYER_ACTIONS.CHOP:
			current_counter.object.ingredients[0].state = Constants.OBJECT_STATES.CHOPPED
		Constants.PLAYER_ACTIONS.BREW:
			# counter object is a keurig
			var juice = current_counter.object.contents
			current_counter.object.remove_child(juice)
			current_counter.object.contents = null
			juice.state = Constants.OBJECT_STATES.IN_CUP
			held_object.add_ingredient(juice)
