extends Control
class_name DieDisplay

signal data_changed(data)

var _dice_data : Dictionary
var data : Dictionary :
	get :
		return _dice_data
	set(val) : 
		_dice_data = val
		data_changed.emit(data)


func _on_data_changed(in_data: Variant) -> void:
	visible = not in_data.is_empty()
