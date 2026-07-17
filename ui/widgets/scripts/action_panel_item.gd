extends Control
class_name ActionPanelItem


@onready var itemLabel : Label = $ItemLabel
@onready var itemDisplay : ItemDisplay = $ItemDisplay
@onready var button : Button = $Button
@onready var neededLabel : Label = $PanelContainer/MarginContainer/CountLabels/Needed
@onready var inventoryLabel : Label = $PanelContainer/MarginContainer/CountLabels/Inventory
@onready var sound : AudioStreamPlayer = $dicerolled


var action : ItemAction


func _ready() -> void:
	button.pressed.connect(_on_do_action_pressed)


func update(a : ItemAction):
	action = a
	itemDisplay.update(a.item_type)
	itemLabel.text = _format_item_label(action.item_type)
	neededLabel.text = str(action.required_number)
	inventoryLabel.text = str(Inventory.count(action.item_type))
	button.disabled = not a.can_afford_action()


func _format_item_label(item : Enums.ItemTypes) -> String:
	return Enums.ItemTypes.keys()[item]


func _on_do_action_pressed() -> void:
	sound.play()
