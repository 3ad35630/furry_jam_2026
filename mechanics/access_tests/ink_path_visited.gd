extends AccessTest
class_name AccessTestInkIntroComplete
func _is_accessible() -> bool:
	if NarrativeSystem.visit_count_at_path("story_intro") > 0:
		return true
	return false
