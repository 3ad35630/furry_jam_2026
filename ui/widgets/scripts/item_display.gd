extends Control
class_name ItemDisplay

@onready var sprite : Sprite2D = $Sprite2D
@onready var label : Label = $Label


## probably not a good way of doing this, but there's really no winning I think
## maybe stick in a Global somewhere, but that's also messy
const itemMap : Dictionary[Enums.ItemTypes,int] = {
	Enums.ItemTypes.UNDEFINED : 2,
	Enums.ItemTypes.MONEY : 2,
	Enums.ItemTypes.FISH : 0,
	Enums.ItemTypes.GOSSIP : 7,
	Enums.ItemTypes.MILK : 8,
	Enums.ItemTypes.TEA : 13,
	Enums.ItemTypes.CINNAMON : 3,
	Enums.ItemTypes.OIL : 16,
	Enums.ItemTypes.BLOSSOMS : 12
}


func update(item : Enums.ItemTypes) -> void:
	sprite.frame = itemMap[item]


func set_text(val : String = '') -> void:
	label.text = val
	if val.is_empty():
		label.hide()
	else:
		label.show()
