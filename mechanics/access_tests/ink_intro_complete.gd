extends AccessTest
class_name AccessTestInkPathVisited
@export var ink_path : String
func _is_accessible() -> bool:
	if NarrativeSystem.visit_count_at_path(ink_path) > 0:
		return true
	return false
