extends Node

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
		

func reset_all_energy() -> void:
	for character in characters:
		character.reset_energy()
