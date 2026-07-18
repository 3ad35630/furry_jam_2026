extends AccessTest
class_name AccessTestRoundNumber

@export var round_accessed : int = 1

func _is_accessible() -> bool:
	return TurnSystem.current_round >= round_accessed
