extends Control
class_name ActionPanelInfo

@export var name_label : Label
@export var skill_label : Label
@export var description_label : Label

func update(action : Action):
	if action:
		name_label.text = action.resource_name
		if action is SkillAction:
			skill_label.text = Enums.Skills.keys()[action.skill].to_lower()
		elif action is ItemAction:
			skill_label.text = 'item'
		description_label.text = action.description
