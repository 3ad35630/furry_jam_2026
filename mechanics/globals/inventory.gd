extends Node

signal inventory_modified(item : Enums.ItemTypes)

var inventory : Dictionary[Enums.ItemTypes, int]

func add(item : Enums.ItemTypes, amount : int) -> void:
	var current = 0
	if inventory.has(item):
		current = inventory[item]
	inventory[item] = current + amount
	inventory_modified.emit(item)

func remove(item : Enums.ItemTypes, amount : int) -> void:
	add(item, -amount)

func has(item : Enums.ItemTypes, amount : int) -> bool:
	if inventory.has(item):
		return inventory[item] >= amount
	return false

func use_item_on_item_action(action : ItemAction, item : Enums.ItemTypes) -> void:
	if action.can_afford_action():
		action.do_action(item)
