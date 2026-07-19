extends Action
class_name ItemAction

@export var item_type : Enums.ItemTypes
@export var required_number : int = 1
@export var result : ActionEffect
@export var spend_items : bool = true

func do_action(_input):
	assert(_input == item_type)
	assert(can_afford_action())
	result.do()
	result_text.clear()
	if spend_items:
		Inventory.remove(item_type, required_number)
		result_text.append("You spent " + str(required_number) + " of your " + Enums.ItemTypes.keys()[item_type].to_lower()+"!")
	result_text.append_array(result.get_result_text())
	super(_input)

func can_afford_action() -> bool:
	return Inventory.has(item_type, required_number)
