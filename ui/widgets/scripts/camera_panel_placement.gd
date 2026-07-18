extends Camera3D

@export var location_display_widget : PackedScene
var panel_targets : Array[Node3D]
var clock_targets : Array[Node3D]

func _ready() -> void:
	for child in get_children():
		if child.is_clock:
			clock_targets.append(child)
		else:
			panel_targets.append(child)
