extends ActionEffect
class_name ShowEndingSlide
func do() -> void:
	Modes.change_gameplay_mode(Enums.GameplayMode.ENDING_SLIDE)
