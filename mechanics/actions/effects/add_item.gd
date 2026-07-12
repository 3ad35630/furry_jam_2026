extends ActionEffect
class_name AddItem

@export var item_type : Enums.ItemTypes
@export var amount : int

func do() -> void:
	Inventory.add(item_type, amount)
