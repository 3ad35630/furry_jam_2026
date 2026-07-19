extends Button

func _on_pressed() -> void:
	Modes.exit_location()
	set_visible(false)

func _process(delta: float) -> void:
	if Modes.current_location != null:
		set_visible(true)
