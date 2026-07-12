extends Action
class_name SkillAction

@export var is_risky : bool
@export var target_number : int
@export var skill : Enums.Skills
@export var positive : ActionEffect
@export var neutral : ActionEffect
@export var negative : ActionEffect

func get_output_type(roll_data) -> Enums.DieActionOutcomeTypes:
	var skill_value = roll_data['character'].get_skill(skill) + roll_data['die_value']
	if skill_value > target_number:	
		return Enums.DieActionOutcomeTypes.GOOD
	if skill_value == target_number:
		return Enums.DieActionOutcomeTypes.NEUTRAL
	return Enums.DieActionOutcomeTypes.BAD

func do_action(roll_data):
	assert(roll_data is Dictionary)
	var output = get_output_type(roll_data)
	var result_roll = randf()
	match output: # this is probably going to be tweaked
		Enums.DieActionOutcomeTypes.GOOD:
			if result_roll >= 0.5:
				do_effect(positive)
			else:
				do_effect(neutral)
		Enums.DieActionOutcomeTypes.NEUTRAL:
			if result_roll >= 0.75:
				do_effect(positive)
			elif result_roll >= 0.25:
				do_effect(neutral)
			else:
				do_effect(negative)
		Enums.DieActionOutcomeTypes.BAD:
			if result_roll <= 0.75:
				do_effect(negative)
			else:
				do_effect(neutral)
	super(roll_data)

func do_effect(effect):
	if effect:
		effect.do()
