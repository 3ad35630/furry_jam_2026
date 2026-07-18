extends AccessTest
class_name AccessTestHasItem

@export var item_type : Enums.ItemTypes

func _is_accessible() -> bool:
	return Inventory.has(item_type, 1)
