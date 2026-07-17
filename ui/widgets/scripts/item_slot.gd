extends Control

## key of item this slot tracks
@export var itemKey : Enums.ItemTypes

@onready var texture : TextureRect = $TextureRect
@onready var label : Label = $Label
@onready var addButton : Button = $Add
@onready var subtractButton : Button = $Subtract


func _ready() -> void:
	update()
	Inventory.inventory_modified.connect(check_update)
	addButton.pressed.connect(Inventory.add.bind(itemKey,1))
	subtractButton.pressed.connect(Inventory.remove.bind(itemKey,1))


func check_update(key : Enums.ItemTypes) -> void:
	if key == itemKey : update()


func update() -> void:
	if Inventory.inventory.has(itemKey):#Inventory.has(itemKey):
		texture.modulate = Color.WHITE
		var ct = Inventory.count(itemKey)
		label.text = str(ct)
		label.visible = true#ct > 1
		tooltip_text = Enums.ItemTypes.keys()[itemKey]
	else:
		texture.modulate = Color.BLACK
		label.visible = false
		tooltip_text = '???'
