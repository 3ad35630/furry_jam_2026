extends Resource
class_name Action

signal action_done

@export var name : String
@export var description : String 
var action_count : int = 0
@export var access_test : AccessTest = null
var accessible : 
	get:
		if access_test != null:
			return access_test.accessible
		return true

func do_action(_input):
	action_count += 1
	action_done.emit()
