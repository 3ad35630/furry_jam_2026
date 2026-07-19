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

@export var color_rect : ColorRect
@export var icon : Sprite2D

func update() -> void:
	color_rect.color = data['character'].color
	icon.frame = int(data['die_value']) - 1
