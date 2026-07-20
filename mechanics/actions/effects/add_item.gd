extends ActionEffect
class_name AddItem

@export var item_type : Enums.ItemTypes
@export var amount : int

func do() -> void:
	Inventory.add(item_type, amount)

func get_result_text() -> Array[String]:
	return ["You got " + str(amount) + " x " + Enums.ItemTypes.keys()[item_type].to_lower() + "!"]
