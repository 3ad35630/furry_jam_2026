extends ActionEffect
class_name StoryMoment
@export var path : String
@export var post_effects : Array[ActionEffect]
func do() -> void:
	NarrativeSystem.start_narrative(path)
	PostNarrativeMomentEffectSystem.register_events(post_effects)
