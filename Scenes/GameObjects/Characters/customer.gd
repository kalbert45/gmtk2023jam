extends PathFollow2D

signal cafe_exit
signal clear_food

enum STATES {WALKING_TO, WALKING_FROM, THINKING, READY, EXITING}
var current_state = STATES.WALKING_TO
var order = null
# is added to path designated by table.
# takes care of walking, movement, animations, orders

# randomize gender
func _ready():
	progress_ratio = 1.0

func walk_to_table():
	current_state = STATES.WALKING_TO
	
func walk_to_exit():
	current_state = STATES.WALKING_FROM

func think():
	current_state = STATES.THINKING
	$Order.generate_order()
	$ThinkingBubble.visible = true
	$ThinkingTimer.start()

func fail_order():
	$Order.visible = false
	$AngryBubble.visible = true
	$EatingTimer.start()
	current_state = STATES.THINKING # to prevent another serve
	
func succeed_order():
	$Order.visible = false
	$LoveBubble.visible = true
	$EatingTimer.start()
	current_state = STATES.THINKING # to prevent another serve
	
func _process(delta):
	if current_state == STATES.WALKING_TO:
		progress -= 70 * delta
		if progress_ratio == 0.0:
			think()
	elif current_state == STATES.WALKING_FROM:
		progress += 70 * delta
		if progress_ratio == 1.0:
			current_state = STATES.EXITING
			emit_signal("cafe_exit")
		

func _on_thinking_timer_timeout():
	$ThinkingBubble.visible = false
	$Order.visible = true
	current_state = STATES.READY


func _on_eating_timer_timeout():
	$LoveBubble.visible = false
	$HateBubble.visible = false
	current_state = STATES.WALKING_FROM
	emit_signal("clear_food")
