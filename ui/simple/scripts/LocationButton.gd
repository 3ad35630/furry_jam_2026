extends Button
class_name LocationButton

@export var _location : Location

var location : Location :
	set(new_location):
		_location = new_location
		text = "Go to: " + new_location.name
	get:
		return _location
		
func _ready() -> void:
	pressed.connect(go_to_location)
	
func go_to_location() -> void:
	Modes.enter_location(location)

func get_location() -> Location:
	return _location
