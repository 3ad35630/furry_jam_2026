extends Control
class_name ActionPanelInfo

@onready var name_label : Label = $NameLabel
@onready var skill_label : Label = $SkillLabel
@onready var description_label : Label = $DescriptionLabel

func update(action : Action):
	name_label.text = action.resource_name
	if action is SkillAction:
		skill_label.text = Enums.Skills.keys()[action.skill].to_lower()
	elif action is ItemAction:
		skill_label.text = 'item'
	description_label.text = action.description
