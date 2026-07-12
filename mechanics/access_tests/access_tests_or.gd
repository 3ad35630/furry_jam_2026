extends AccessTest
class_name AccessTests_OR

@export var tests : Array[AccessTest]

func _is_accessible() -> bool:
	for test in tests:
		if test.accessible:
			return true
	return false
