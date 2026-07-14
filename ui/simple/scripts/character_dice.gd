extends HBoxContainer

var hbox_dict : Dictionary[Character, HBoxContainer] = {}
@export var char_dice : PackedScene
@export var witch : Resource

func _ready() -> void:
	for character in Characters.characters:
		if character == witch:
			character.dice_updated.connect(update_dice_display_for_character)
			var new_hbox = HBoxContainer.new()
			add_child(new_hbox)
			hbox_dict[character] = new_hbox
			update_dice_display_for_character(character)
		
func update_dice_display_for_character(character : Character) -> void:
	for child in hbox_dict[character].get_children():
		hbox_dict[character].remove_child(child)
		child.queue_free()
	for die in character.dice_dicts:
		var new_dice_display = char_dice.instantiate()
		new_dice_display.data = die
		hbox_dict[character].add_child(new_dice_display)

func on_skill_die_removed(data):
	for display in hbox_dict[data['character']].get_children():
		if display.data['index'] == data['index']:
			display.visible = true
