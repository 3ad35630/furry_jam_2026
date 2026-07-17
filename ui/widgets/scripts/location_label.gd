extends Label

@export var defaultTitle : String = 'Moon'

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)


func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	match(mode):
		Enums.GameplayMode.LOCATION:
			text = Modes.current_location.name
		_:
			text = defaultTitle
