extends Control
class_name ActionPanelInfo

@export var description_label : Label

func update(action : Action):
	if action:
		description_label.text = action.description
