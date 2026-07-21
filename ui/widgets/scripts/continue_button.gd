extends MainMenuButton

@export var setMode : Enums.GameplayMode = Enums.GameplayMode.MAP

func _on_ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)
	visible = not Modes.newGame


func _on_press() -> void:
	Modes.change_gameplay_mode(setMode)


func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	visible = not Modes.newGame
	Modes.gameplay_mode_changed.disconnect(_on_mode_changed)
