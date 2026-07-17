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

func get_all_location_resource_paths() -> Array[String]:
	var results : Array[String] = []
	var directories : Array[String] = [location_directory]
	for directory in directories:
		var d = DirAccess.open(directory)
		d.list_dir_begin()
		var current = d.get_next()
		while not current.is_empty():
			var full = directory + current
			current = d.get_next()
			if d.current_is_dir():
				directories.append(full + "/")
				continue
			results.append(full)
	return results

func _ready() -> void:
	# gets all locations in folder
	var location_resources = get_all_location_resource_paths()
	for file_path in location_resources:
		var new_location = load(file_path)
		if new_location:
			locations[new_location.location_id] = new_location
			for clock in new_location.clocks:
				clocks[clock.clock_id] = clock
				clock.subscribe_to_turn_system() # we do this here because we need to do it somewhere...
