extends Node2D

# if ingredients includes bread, and 1+, make sandwich
# ingredients stack priority
# max 4 stack
var object_type = Constants.OBJECT_TYPES.COMBINATION
# array of objects
var ingredients = []

# adds ingredient to combo. only used to initialize.
func add_ingredient(ing):
	add_child(ing)
	ingredients.append(ing)
	sort()

# adds combo to this combo. sort by stack priority (uses function types)
func add_combo(combo):
	for i in combo.ingredients:
		combo.remove_child(i)
		add_child(i)
		ingredients.append(i)
		
	combo.queue_free()
	sort()

# sort based on stack priority
func sort():
	var sorted_nodes = get_children()
	
	sorted_nodes.sort_custom(
		func(a, b): return a.function.order < b.function.order
	)
	
	for node in get_children():
		remove_child(node)
		
	for node in sorted_nodes:
		add_child(node)

# deletes all except plate/cup
func clear():
	for i in ingredients:
		if i.function_type == Constants.OBJECTS.PLATE:
			continue
		ingredients.erase(i)
		i.queue_free()
	
# returns a recipe
func check_recipe():
	pass
	
# given another combo, checks if they are combinable
# checks: max 4 stack
# no repeat ingredients
# no double plates
func check_combo(from):
	var size = ingredients.size() + from.ingredients.size()
	if size > 4:
		return false
		
	for i in ingredients:
		for j in from.ingredients:
			if i.type == j.type:
				return false
			if (i.function.function_type == Constants.OBJECT_TYPES.PLATE) and (j.function.function_type == Constants.OBJECT_TYPES.PLATE):
				return false
	
	return true
	
# check if choppable
func is_choppable():
	if ingredients.size() != 1:
		return false

	if !ingredients[0].function.choppable:
		return false

	if ingredients[0].state != Constants.OBJECT_STATES.DEFAULT:
		return false
		
	return true
	
func is_brewable():
	if ingredients.size() != 1:
		return false

	if !ingredients[0].function.brewable:
		return false

	if ingredients[0].state != Constants.OBJECT_STATES.DEFAULT:
		return false
		
	return true
	
func is_cup():
	if ingredients.size() != 1:
		return false

	if !ingredients[0].function.object_type == Constants.OBJECTS.CUP:
		return false

	if ingredients[0].state != Constants.OBJECT_STATES.DEFAULT:
		return false
		
	return true
	
