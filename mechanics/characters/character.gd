extends Resource
class_name Character

signal dice_updated(character : Character)

@export var max_energy : int
var current_energy : int
@export var name : String
@export var icon : Texture2D
@export var color : Color
@export var skills : Dictionary[Enums.Skills, int]

var dice : Array[int]
var dice_dicts : Array[Dictionary]:
	get = get_dice_dictionary



func reset_energy():
	current_energy = max_energy

func get_skill(skill_type : Enums.Skills) -> int:
	if skills.has(skill_type):
		return skills[skill_type]
	return 0

func roll_dice() -> void:
	dice.clear()
	for x in range(current_energy):
		dice.append(randi_range(1,6))
	dice_updated.emit(self)

func spend_die(index) -> void:
	assert(index < dice.size())
	dice.remove_at(index)
	dice_updated.emit(self)

func get_dice_dictionary() -> Array[Dictionary]:
	var result : Array[Dictionary] = []
	for x in range(dice.size()):
		result.append({
			'character':self,
			'die_value':dice[x], 
			'index':x})
	return result
