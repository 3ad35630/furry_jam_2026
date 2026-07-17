extends Node

var location_directory = "res://resources/locations/"
var locations : Dictionary[String,Location]
var clocks : Dictionary[String,Clock]

var accessible_locations : Array[Location] : 
	get :
		var result : Array[Location] = []
		for location in locations.values():
			if location.accessible:
				result.append(location)
		return result
var accessible_clocks : Array[Clock] :
	get : 
		var result : Array[Clock] = []
		for clock : Clock in clocks.values():
			if clock.accessible:
				result.append(clock)
		return result


func _ready() -> void:
	# gets all locations in folder
	var location_resources = ResourceLoader.list_directory(location_directory)
	for file_name in location_resources:
		var new_location = load(location_directory + file_name)
		locations[new_location.location_id] = new_location
		for clock in new_location.clocks:
			clocks[clock.clock_id] = clock
			clock.subscribe_to_turn_system() # we do this here because we need to do it somewhere...
