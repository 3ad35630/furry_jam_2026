extends Resource
class_name Location

@export var name : String
@export var description: String
@export var location_id : String
@export var data : Dictionary
@export var access_test : AccessTest = null
@export var actions : Array[Action]
@export var clocks : Array[Clock]

var accessible : 
	get:
		if access_test != null:
			return access_test.accessible
		return true

func set_data(key : String, value : Variant):
	data[key] = value

func get_data(key : String):
	if has_data(key):
		return data[key]
	
func has_data(key : String) -> bool:
	return data.has(key)
