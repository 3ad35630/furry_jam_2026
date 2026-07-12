extends MarginContainer
class_name SimpleDieDisplay

signal data_changed(data)

var _dice_data : Dictionary
var data : Dictionary :
	get :
		return _dice_data
	set(val) : 
		_dice_data = val
		data_changed.emit(data)
		if not _dice_data.is_empty():
			update()

@export var label : Label
@export var color_rect : ColorRect

func update() -> void:
	color_rect.color = data['character'].color
	label.text = str(data['die_value'])
