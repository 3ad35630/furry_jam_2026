extends Node

const ingredients : Array[Enums.ItemTypes] = [
	Enums.ItemTypes.MILK,
	Enums.ItemTypes.OIL,
	Enums.ItemTypes.BLOSSOMS,
	Enums.ItemTypes.TEA,
	Enums.ItemTypes.CINNAMON
]

signal inventory_modified(item : Enums.ItemTypes)

var inventory : Dictionary[Enums.ItemTypes, int]

func add(item : Enums.ItemTypes, amount : int = 1) -> void:
	var current = 0
	if inventory.has(item):
		current = inventory[item]
	inventory[item] = max(0,current + amount) # prevents negative values
	inventory_modified.emit(item)

func remove(item : Enums.ItemTypes, amount : int = 1) -> void:
	add(item, -amount)

func has(item : Enums.ItemTypes, amount : int = 1) -> bool:
	if inventory.has(item):
		return inventory[item] >= amount
	return false

func count(item : Enums.ItemTypes) -> int:
	if inventory.has(item):
		return inventory[item]
	return 0

func use_item_on_item_action(action : ItemAction, item : Enums.ItemTypes) -> void:
	if action.can_afford_action():
		action.do_action(item)


## returns the total number of ingredients acquired
func get_ingredient_count() -> int:
	var ctr = 0
	for item in ingredients:
		if has(item):
			ctr += 1
	return ctr

## checks if all ingredients have been acquired
func has_all_ingredients() -> bool:
	var ct = get_ingredient_count()
	return ct == ingredients.size()
