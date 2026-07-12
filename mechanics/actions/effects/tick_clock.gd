extends ActionEffect
class_name TickClock

@export var clock_id: String
@export var amount : int = 1

func do() -> void:
	assert(Locations.clocks.has(clock_id))
	Locations.clocks[clock_id].tick(amount)
