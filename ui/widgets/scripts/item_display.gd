extends Control
class_name ItemDisplay

@onready var sprite : Sprite2D = $Sprite2D

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
