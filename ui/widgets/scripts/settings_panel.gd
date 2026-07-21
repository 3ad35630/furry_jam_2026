extends CenterContainer

@onready var credits = %CreditsPanel
@onready var settings = %SettingsPanelMono#%SettingsPanel
@onready var controls = %ControlsPanel

func _on_button_2_pressed() -> void:
	visible = true
	credits.visible = false
	settings.visible = true
	controls.visible = false
	
func _on_button_3_pressed() -> void:
	visible = true
	credits.visible = true
	settings.visible = false
	controls.visible = false


func _on_back_button_pressed() -> void:
	visible = false


func _on_controls_button_pressed() -> void:
	visible = true
	credits.visible = false
	settings.visible = false
	controls.visible = true
