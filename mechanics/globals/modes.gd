extends Node

signal gameplay_mode_changed(new_mode : Enums.GameplayMode)

var current_mode : Enums.GameplayMode = Enums.GameplayMode.MAINMENU
var previous_mode : Enums.GameplayMode = Enums.GameplayMode.MAP
var current_location : Location = null
var newGame : bool = true


func enter_location(new_location : Location) -> void:
	current_location = new_location
	change_gameplay_mode(Enums.GameplayMode.CAMERA_MOVEMENT)
	await get_viewport().get_camera_3d().tween_to_location(new_location)
	change_gameplay_mode(Enums.GameplayMode.LOCATION)
	
func exit_location() -> void:
	current_location = null
	change_gameplay_mode(Enums.GameplayMode.CAMERA_MOVEMENT)
	await get_viewport().get_camera_3d().tween_to_map()
	change_gameplay_mode(Enums.GameplayMode.MAP)

func change_gameplay_mode(new_mode : Enums.GameplayMode) -> void:
	newGame = false  # a little inelegant
	previous_mode = current_mode
	current_mode = new_mode
	gameplay_mode_changed.emit(current_mode)
