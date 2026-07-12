extends AccessTest
class_name AccessTests_AND

@export var tests : Array[AccessTest]

func _is_accessible() -> bool:
	for test in tests:
		if not test.accessible:
			return false
	return true
