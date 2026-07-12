extends AccessTest
class_name AccessTestClockCompleted

@export var clock_id : String

func _is_accessible() -> bool:
	assert(Locations.clocks.has(clock_id))
	return Locations.clocks[clock_id].complete
