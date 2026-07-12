extends Node

var data : Dictionary

func set_data(key : String, value : Variant):
	data[key] = value

func get_data(key : String):
	if has_data(key):
		return data[key]
	
func has_data(key : String) -> bool:
	return data.has(key)
