extends MainMenuButton

@export var setMode : Enums.GameplayMode = Enums.GameplayMode.MAP
@export var resumeText : String = 'Continue'

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)
	hide()


func _on_press() -> void:
	Modes.change_gameplay_mode(setMode)


func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	show()
	Modes.gameplay_mode_changed.disconnect(_on_mode_changed)
