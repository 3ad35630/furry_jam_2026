extends ActionEffect
class_name RemoveItem

@export var item_type : Enums.ItemTypes
@export var amount : int

func do() -> void:
	Inventory.remove(item_type, amount)
