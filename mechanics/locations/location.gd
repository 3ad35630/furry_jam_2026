extends Resource
class_name Location

@export var name : String
@export var description: String
@export var location_id : String
@export var data : Dictionary
@export var access_test : AccessTest = null
@export var actions : Array[Action] = []
@export var clocks : Array[Clock] = []

var accessible : bool : 
	get:
		if access_test != null:
			return access_test.accessible
		return true

var accessible_actions : Array[Action] :
	get :
		var result : Array[Action] = []
		for action in actions:
			if action.accessible:
				result.append(action)
		return result

var accessible_clocks : Array[Clock] :
	get :
		var result : Array[Clock] = []
		for clock in clocks:
			if clock.accessible:
				result.append(clock)
		return result

func set_data(key : String, value : Variant):
	data[key] = value

func get_data(key : String):
	if has_data(key):
		return data[key]
	
func has_data(key : String) -> bool:
	return data.has(key)
