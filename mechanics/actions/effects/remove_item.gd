extends ActionEffect
class_name RemoveItem

@export var item_type : Enums.ItemTypes
@export var amount : int

func do() -> void:
	Inventory.remove(item_type, amount)

func get_result_text() -> Array[String]:
	return ["You lost " + str(amount) + " x " + Enums.ItemTypes.keys()[item_type].to_lower() + "!"]
