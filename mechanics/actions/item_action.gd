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
	if spend_items:
		Inventory.remove(item_type, required_number)
	super(_input)

func can_afford_action() -> bool:
	return Inventory.has(item_type, required_number)
