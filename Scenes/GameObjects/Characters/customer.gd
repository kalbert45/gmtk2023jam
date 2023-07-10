extends PathFollow2D

signal cafe_exit
signal clear_food

enum STATES {WALKING_TO, WALKING_FROM, THINKING, READY, EXITING}
var current_state = STATES.WALKING_TO
@onready var order = $Order
# is added to path designated by table.
# takes care of walking, movement, animations, orders

# randomize gender
func _ready():
	var rand = randi_range(0, 1)
	if rand == 0:
		$NPCSprite.texture = load("res://Assets/Sprites/Characters/npc_guy.png")
	else:
		$NPCSprite.texture = load("res://Assets/Sprites/Characters/npc_girl.png")
	
	$Order.order_timeout.connect(_on_order_timeout)
	progress_ratio = 1.0

func _on_order_timeout():
	fail_order()

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
	Global.play_sfx('wrong_order.wav')
	$Order.visible = false
	$AngryBubble.visible = true
	$EatingTimer.start()
	Global.lives -= 1
	current_state = STATES.THINKING # to prevent another serve
	
func succeed_order():
	Global.play_sfx('order_success.wav')
	$Order.visible = false
	$LoveBubble.visible = true
	$EatingTimer.start()
	$Order.stop_wait()
	current_state = STATES.THINKING # to prevent another serve
	
func _process(delta):
	if current_state == STATES.WALKING_TO:
		progress -= 80 * delta
		if progress_ratio == 0.0:
			think()
	elif current_state == STATES.WALKING_FROM:
		progress += 80 * delta
		if progress_ratio == 1.0:
			current_state = STATES.EXITING
			emit_signal("cafe_exit")
		

func _on_thinking_timer_timeout():
	Global.play_sfx('order_decided.wav', -5)
	$ThinkingBubble.visible = false
	$Order.visible = true
	$Order.start_wait()
	current_state = STATES.READY


func _on_eating_timer_timeout():
	$LoveBubble.visible = false
	$AngryBubble.visible = false
	current_state = STATES.WALKING_FROM
	emit_signal("clear_food")
