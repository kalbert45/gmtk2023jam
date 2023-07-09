extends Node

@export var tables_node : NodePath

var visitors = 3 # decreases when customer enters building
var customers = 3 : set = _set_customer_count # decreases when served fully. day ends when this hits 0
var timer_range = [19, 21]

# keeps track of number of customers and has timer that progresses
# ends day when applicable
func _ready():
	SignalBus.customer_exit.connect(_on_customer_exit)
	SignalBus.new_day.connect(start)
	if !Global.first:
		start()
		
	# adjust difficulty based on day
	match Global.day:
		1:
			visitors = 3
			self.customers = 3
			timer_range = [19, 21]
		2:
			visitors = 3
			self.customers = 3
			timer_range = [19, 21]
			# point 1
		3:
			visitors = 4
			self.customers = 4
			timer_range = [19, 21]
		4:
			visitors = 4
			self.customers = 4
			timer_range = [19, 21]
		5:
			visitors = 4
			self.customers = 4
			timer_range = [19, 21]
			# point 2
		6:
			visitors = 5
			self.customers = 5
			timer_range = [18, 20]
		7:
			visitors = 5
			self.customers = 5
			timer_range = [18, 20]
		8:
			visitors = 5
			self.customers = 5
			timer_range = [18, 20]
		9:
			visitors = 5
			self.customers = 5
			timer_range = [18, 20]
		10:
			visitors = 6
			self.customers = 6
			timer_range = [16, 21]
		11:
			visitors = 6
			self.customers = 6
			timer_range = [16, 21]
		12:
			visitors = 6
			self.customers = 6
			timer_range = [16, 21]
		13:
			visitors = 6
			self.customers = 6
			timer_range = [16, 21]
			# point 3
		14:
			visitors = 7
			self.customers = 7
			timer_range = [14, 19]
		_:
			visitors = 7
			self.customers = 7
			timer_range = [14, 19]
		

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
			
	$CustomerTimer.wait_time = randi_range(timer_range[0], timer_range[1])
			
func _on_customer_exit():
	self.customers -= 1

func _set_customer_count(value):
	customers = value
	if customers <= 0:
		print('end_day')
		SignalBus.emit_signal('end_day')
