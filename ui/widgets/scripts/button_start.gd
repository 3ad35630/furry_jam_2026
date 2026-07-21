extends MainMenuButton

@export var setMode : Enums.GameplayMode = Enums.GameplayMode.MAP
@export var resumeText : String = 'Continue'

func _on_press() -> void:
	Modes.change_gameplay_mode(setMode)
	hide()


#func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	#match(mode):
		#Enums.GameplayMode.MAP:
			#text = resumeText
