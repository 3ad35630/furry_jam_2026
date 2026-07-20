extends Node

var effects : Array[ActionEffect]

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(on_mode_changed)

func on_mode_changed(_new_mode : Enums.GameplayMode) -> void:
	if Modes.previous_mode == Enums.GameplayMode.NARRATIVE:
		for effect in effects:
			effect.do()
		effects = []

func register_events(events :Array[ActionEffect]) -> void:
	effects.append_array(events)
