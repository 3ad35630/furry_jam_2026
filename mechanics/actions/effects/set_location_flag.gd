extends ActionEffect
class_name SetLocationFlag

@export var location_id : String
@export var key : String
@export var value : bool = true

func do() -> void:
	assert(Locations.locations.has(location_id))
	Locations.locations[location_id].set_data(key, value)
