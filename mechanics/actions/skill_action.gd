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


func do_effect(effect):
	if effect:
		effect.do()
		result_text.append_array(effect.get_result_text())


func do_action(roll_data):
	assert(roll_data is Dictionary)
	var probs = get_outcome_probabilities(roll_data)
	var result_roll = randf()
	result_text.clear()
	if result_roll < probs[Enums.EffectClasses.POSITIVE]:
		do_effect(positive)
	elif result_roll < probs[Enums.EffectClasses.POSITIVE] + probs[Enums.EffectClasses.NEUTRAL]:
		do_effect(neutral)
	else:
		do_effect(negative)
	super(roll_data)


## get probabilities of each outcome for each dice roll to communicate to player
## NOTE: Can probably merge EffectClasses & DieActionOutcomeTypes ... former has one extra value
##    used EffectClasses here to avoid confusion with meaning of DieActionOutcomeTypes as shown above
func get_outcome_probabilities(rollData : Dictionary) -> Dictionary[Enums.EffectClasses,float]:
	var outcomes : Dictionary[Enums.EffectClasses,float] = {
		Enums.EffectClasses.POSITIVE : 0,
		Enums.EffectClasses.NEUTRAL : 0,
		Enums.EffectClasses.NEGATIVE : 0,
	}
	
	var output = get_output_type(rollData)
	match(output):
		Enums.DieActionOutcomeTypes.GOOD:
			outcomes[Enums.EffectClasses.POSITIVE] = 0.5
			outcomes[Enums.EffectClasses.NEGATIVE] = 0.5
		Enums.DieActionOutcomeTypes.NEUTRAL:
			outcomes[Enums.EffectClasses.POSITIVE] = 0.25
			outcomes[Enums.EffectClasses.NEUTRAL] = 0.5
			outcomes[Enums.EffectClasses.NEGATIVE] = 0.25
		Enums.DieActionOutcomeTypes.BAD:
			outcomes[Enums.EffectClasses.NEUTRAL] = 0.25
			outcomes[Enums.EffectClasses.NEGATIVE] = 0.75
	
	return outcomes
