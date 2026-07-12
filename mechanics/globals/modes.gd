extends Node

signal gameplay_mode_changed(new_mode : Enums.GameplayMode)

var current_mode : Enums.GameplayMode = Enums.GameplayMode.MAP
var previous_mode : Enums.GameplayMode = Enums.GameplayMode.MAP
var current_location : Location = null

func enter_location(new_location : Location) -> void:
	current_location = new_location
	change_gameplay_mode(Enums.GameplayMode.LOCATION)
	
func exit_location() -> void:
	current_location = null
	change_gameplay_mode(Enums.GameplayMode.MAP)

func change_gameplay_mode(new_mode : Enums.GameplayMode) -> void:
	previous_mode = current_mode
	current_mode = new_mode
	gameplay_mode_changed.emit(current_mode)
