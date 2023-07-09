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
	SignalBus.emit_signal('customer_exit')
	occupant.queue_free()
	occupant = null
	
func _on_clear_food():
	if food:
		food.queue_free()
		food = null
	
# perform checks to see if fail or success
func serve(object):
	food = object
	add_child(food)
	
	if food.check_recipe() == occupant.order.correct_dish:
		occupant.succeed_order()
	else:
		occupant.fail_order()
	

