extends HBoxContainer

@export var char_dice : PackedScene
@export var witch : Resource

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(on_gameplay_mode_changed)
	for character in Characters.characters:
		if character == witch:
			witch = character # we want them to be the same Resource
			character.dice_updated.connect(update_dice_display_for_character)
			update_dice_display_for_character(character)
		
func update_dice_display_for_character(character : Character) -> void:
	for child in get_children():
		child.queue_free()
	for die in character.dice_dicts:
		var new_dice_display = char_dice.instantiate()
		new_dice_display.data = die
		new_dice_display.remove_if_successfully_dragged = true
		add_child(new_dice_display)
		
func on_gameplay_mode_changed(new_mode : Enums.GameplayMode) -> void:
	match new_mode:
		Enums.GameplayMode.LOCATION:
			update_dice_display_for_character(witch)
		Enums.GameplayMode.MAP:
			update_dice_display_for_character(witch)
