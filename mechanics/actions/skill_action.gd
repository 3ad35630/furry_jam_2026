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
				positive.do()
			else:
				neutral.do()
		Enums.DieActionOutcomeTypes.NEUTRAL:
			if result_roll >= 0.75:
				positive.do()
			elif result_roll >= 0.25:
				neutral.do()
			else:
				negative.do()
		Enums.DieActionOutcomeTypes.BAD:
			if result_roll <= 0.75:
				negative.do()
			else:
				neutral.do()
	super(roll_data)
