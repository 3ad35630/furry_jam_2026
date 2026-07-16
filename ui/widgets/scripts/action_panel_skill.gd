extends Control
class_name ActionPanelSkill

signal skill_die_removed(data)

@onready var target_number_label : Label = $TargetLabel
@onready var dice_slot : DiceSlot = $DiceSlot
@onready var button : Button = $Button
@onready var sound : AudioStreamPlayer = $dicerolled

var action : SkillAction
var dice_data : 
	get :
		return dice_slot.display.data


func _ready() -> void:
	button.pressed.connect(_on_do_action_pressed)
	dice_slot.display.data_changed.connect(_on_die_display_data_changed)


func update(a : SkillAction):
	action = a
	target_number_label.text = "Target Number: " + str(action.target_number)
	button.disabled = not dice_slot.has_data()
	dice_slot.update()


func _on_do_action_pressed() -> void:
	var data = dice_data
	dice_slot.clear_data()
	SkillDice.use_skill_die_on_action(action, data)
	sound.play()


## process die removal
func _on_die_display_drag_ended(_display: SimpleDieDisplay, data : Dictionary, _success: bool) -> void:
	skill_die_removed.emit(data)


## process updates to the dice display
func _on_die_display_data_changed(data: Variant) -> void:
	button.disabled = not (typeof(data) == TYPE_DICTIONARY and not data.is_empty())
