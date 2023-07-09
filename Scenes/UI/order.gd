extends Control

var correct_dish

var timer_started = false
signal order_timeout

func _ready():
	$PatienceBar.max_value = $PatienceTimer.wait_time
	$PatienceBar.value = $PatienceBar.max_value

func start_wait():
	timer_started = true
	$PatienceTimer.start()

func stop_wait():
	timer_started = false
	$PatienceTimer.stop()

func _process(delta):
	if timer_started:
		$PatienceBar.value = $PatienceTimer.time_left

# create random order. Add appropriate textures according to function
func generate_order():
	var recipe_id = Global.RECIPE_DICT.keys().pick_random()
	correct_dish = recipe_id
	var recipe = Global.RECIPE_DICT[recipe_id].instantiate()
	
	# for each item in recipe, get appropriate ingredient according to function
	# set state
	# set basic tex for ing bubbles
	
	for i in range(recipe.get_children().size()):
		var ingredient_id = Global.swap_dict_rev[recipe.get_child(i).function_type]
		var ingredient
		match ingredient_id:
			Constants.OBJECTS.BREAD:
				ingredient = load('res://Scenes/GameObjects/Objects/bread.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_bread.png')
			Constants.OBJECTS.COFFEE_BEAN:
				ingredient = load('res://Scenes/GameObjects/Objects/coffee_bean.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_coffeebean.png')
			Constants.OBJECTS.CUCUMBER:
				ingredient = load('res://Scenes/GameObjects/Objects/cucumber.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_cucumber.png')
			Constants.OBJECTS.CUP:
				ingredient = load('res://Scenes/GameObjects/Objects/cup.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_cup.png')
			Constants.OBJECTS.KEURIG:
				ingredient = load('res://Scenes/GameObjects/Objects/keurig.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_keurig.png')
			Constants.OBJECTS.KNIFE:
				ingredient = load('res://Scenes/GameObjects/Objects/knife.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_knife.png')
			Constants.OBJECTS.LETTUCE:
				ingredient = load('res://Scenes/GameObjects/Objects/lettuce.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_lettuce.png')
			Constants.OBJECTS.PLATE:
				ingredient = load('res://Scenes/GameObjects/Objects/plate.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_plate.png')
			Constants.OBJECTS.TOMATO:
				ingredient = load('res://Scenes/GameObjects/Objects/tomato.tscn').instantiate()
				if i > 0:
					get_node('Ingredients/bubble'+str(i)).visible = true
					get_node('Ingredients/bubble'+str(i)+'/tex'+str(i)).texture = load('res://Assets/Sprites/Objects/basic_tomato.png')

		$Bubble/Order/combo.add_ingredient(ingredient)
		ingredient.state = recipe.get_child(i).state


func _on_patience_timer_timeout():
	timer_started = false
	emit_signal("order_timeout")
