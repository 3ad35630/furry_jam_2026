extends ActionEffect
class_name GoToLocation

@export var location_id : String

func do() -> void:
	assert(Locations.locations.has(location_id))
	Modes.enter_location(Locations.locations[location_id])
