extends Node

signal all_dice_spent()

var characters : Array[Character]
var character_directory = "res://resources/characters/"


func _ready() -> void:
	# gets all characters in folder
	var character_resources = ResourceLoader.list_directory(character_directory)
	for file_name in character_resources:
		var new_character = load(character_directory + file_name)
		# roll dice on new round
		TurnSystem.round_ended.connect(new_character.roll_dice) 
		characters.append(new_character)
		new_character.dice_updated.connect(_on_dice_updated)

func reset_all_energy() -> void:
	for character in characters:
		character.reset_energy()


func check_all_dice_spent() -> bool:
	var diceSpent : bool = true
	for c in characters:
		if c.dice.size() > 0:
			diceSpent = false
			break
	return diceSpent


func _on_dice_updated(_c : Character) -> void:
	if check_all_dice_spent():
		all_dice_spent.emit()
