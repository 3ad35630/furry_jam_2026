extends Node

signal dice_rerolled()


func _ready() -> void:
	TurnSystem.round_ended.connect(roll_all_dice)

func get_dice_dictionary() -> Array[Dictionary]:
	var result : Array[Dictionary] = []
	for character in Characters.characters:
		result.append_array(character.dice_dicts)
	return result

func use_skill_die_on_action(action : Action, die : Dictionary) -> void:
	action.do_action(die)
	die['character'].spend_die(die['index'])

func roll_all_dice() -> void:
	for character in Characters.characters:
		character.roll_dice()
	dice_rerolled.emit()
