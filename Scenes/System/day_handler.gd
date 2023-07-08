extends Node

@export var tables_node : NodePath

var visitors = 3 # decreases when customer enters building
var customers = 3 : set = _set_customer_count # decreases when served fully. day ends when this hits 0

# keeps track of number of customers and has timer that progresses
# ends day when applicable
func _ready():
	start()

func start():
	$CustomerTimer.start()

func _on_customer_timer_timeout():
	if visitors <= 0:
		return
	
	var tables = get_node(tables_node).get_children()
	tables.shuffle()
	
	for t in tables:
		if !t.occupant:
			print('customer spawned')
			t.generate_customer()
			visitors -= 1
			break
			
	
func _set_customer_count(value):
	customers = value
	if customers <= 0:
		SignalBus.emit_signal('end_day')
