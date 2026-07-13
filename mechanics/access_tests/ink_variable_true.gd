extends AccessTest
class_name AccessTestInkVariableTrue
@export var variable_name : String
func _is_accessible() -> bool:
	if NarrativeSystem.get_variable(variable_name):
		return true
	return false
