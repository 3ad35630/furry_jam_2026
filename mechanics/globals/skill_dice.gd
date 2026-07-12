extends Node

func get_dice_dictionary() -> Array[Dictionary]:
	var result = Array()
	for character in Characters.characters:
		for x in range(character.dice.size()):
			result.append({
				'character':character,
				'die_value':character.dice[x], 
				'index':x})
	return result

func use_skill_die_on_action(action : Action, die : Dictionary) -> void:
	action.do_action(die)
	die['character'].spend_die(die['index'])
