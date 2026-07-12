extends AccessTest
class_name AccessTests_NOT

@export var test : AccessTest

func _is_accessible() -> bool:
	return not test.accessible
