extends Resource
class_name Action

## This action is feeding a clock and should become inaccessible when the clock is complete.
@export var action_clock_id : String

signal action_done

@export var description : String 
var action_count : int = 0
@export var access_test : AccessTest = null
var accessible : 
	get:
		if not action_clock_id.is_empty():
			assert(Locations.clocks.has(action_clock_id))
			if Locations.clocks[action_clock_id].complete:
				return false
			elif not Locations.clocks[action_clock_id].accessible:
				return false
		if access_test != null:
			return access_test.accessible
		return true

func do_action(_input):
	action_count += 1
	action_done.emit()
