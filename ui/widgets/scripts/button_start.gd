extends MainMenuButton

@export var setMode : Enums.GameplayMode = Enums.GameplayMode.MAP
@export var resumeText : String = 'Resume Game'
@export var actions: Array[ActionEffect]

func _on_press() -> void:
	Modes.change_gameplay_mode(setMode)
	Modes.change_gameplay_mode(Enums.GameplayMode.NARRATIVE)
	NarrativeSystem.start_narrative("exit_main_menu")
	PostNarrativeMomentEffectSystem.register_events(actions)

#func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	#match(mode):
		#Enums.GameplayMode.MAP:
			#text = resumeText
