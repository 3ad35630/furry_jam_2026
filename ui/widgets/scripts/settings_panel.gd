extends CenterContainer

@onready var credits = $CreditsPanel
@onready var settings = $SettingsPanel

func _on_button_2_pressed() -> void:
	visible = true
	credits.visible = false
	settings.visible = true
	
func _on_button_3_pressed() -> void:
	visible = true
	credits.visible = true
	settings.visible = false


func _on_back_button_pressed() -> void:
	visible = false
