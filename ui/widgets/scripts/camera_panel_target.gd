extends Node3D
@export var is_clock = false
var valid_screen_position : bool :
	get:
		return not get_viewport().get_camera_3d().is_position_behind(global_position)
## unsafe, test for validity before using
var screen_position : Vector2 : 
	get:
		return get_viewport().get_camera_3d().unproject_position(global_position)
