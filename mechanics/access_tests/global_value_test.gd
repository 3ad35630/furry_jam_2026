extends AccessTest
class_name AccessTestGlobalValue

@export var key : String

func _is_accessible() -> bool:
	var value = ScratchPad.get_data(key)
	if value:
		return true
	return false
