extends ActionEffect
class_name StoryMoment
@export var path : String
func do() -> void:
	NarrativeSystem.start_narrative(path)
