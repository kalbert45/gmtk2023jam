extends Node2D

# handles orders, generates customers.
const customer_scene = preload('res://Scenes/GameObjects/Characters/customer.tscn')

var occupant = null
var food = null
@export var path : Path2D

func interact(_player):
	if occupant:
		if occupant.current_state == occupant.STATES.READY:
			return Constants.PLAYER_ACTIONS.SERVE
	return Constants.PLAYER_ACTIONS.NOTHING

# create new customer
# connect customer to cafe exit func
func generate_customer():
	occupant = customer_scene.instantiate()
	path.add_child(occupant)
	occupant.cafe_exit.connect(_on_cafe_exit)
	occupant.clear_food.connect(_on_clear_food)
	occupant.walk_to_table()

func _on_cafe_exit():
	occupant.queue_free()
	occupant = null
	
func _on_clear_food():
	if food:
		food.queue_free()
		food = null
	
func serve(object):
	pass
	

