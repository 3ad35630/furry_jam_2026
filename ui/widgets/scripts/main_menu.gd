extends Panel


func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)


func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	visible = mode == Enums.GameplayMode.MAINMENU
