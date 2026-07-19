extends Control

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)

func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	match(mode):
		Enums.GameplayMode.LOCATION:
			var location_camera = get_viewport().get_camera_3d().current_location_camera
			var new_widget = location_camera.location_display_widget.instantiate()
			add_child(new_widget)
