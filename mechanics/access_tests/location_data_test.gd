extends AccessTest
class_name AccessTestLocationValue

@export var location_id : String
@export var key : String

func _is_accessible() -> bool:
	assert(Locations.locations.has(location_id))
	var value = Locations.locations[location_id].get_data(key)
	if value:
		return true
	return false
