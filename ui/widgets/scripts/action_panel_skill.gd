extends Control
class_name ActionPanelSkill

signal skill_die_removed(data)

@onready var target_number_label : Label = $TargetLabel
@onready var dice_slot : DiceSlot = $DiceSlot
@onready var button : Button = $Button
@onready var sound : AudioStreamPlayer = $dicerolled
@onready var chanceLabels : Control = $PanelContainer/MarginContainer/ChanceLabels
@onready var bonusLabel : Label = $PanelContainer/MarginContainer/ChanceLabels/Bonus
@onready var posLabel : Label = $PanelContainer/MarginContainer/ChanceLabels/Pos
@onready var neuLabel : Label = $PanelContainer/MarginContainer/ChanceLabels/Neu
@onready var negLabel : Label = $PanelContainer/MarginContainer/ChanceLabels/Neg

var action : SkillAction
var dice_data : 
	get :
		return dice_slot.display.data


func _ready() -> void:
	button.pressed.connect(_on_do_action_pressed)
	dice_slot.display.data_changed.connect(_on_die_display_data_changed)


func update(a : SkillAction):
	action = a
	#target_number_label.text = "Target Number: " + str(action.target_number)
	button.disabled = not dice_slot.has_data()
	update_dice_info()
	dice_slot.update()


func update_dice_info() -> void:
	if dice_slot.has_data():
		button.text = "Confirm"
		var bonus = dice_data['character'].get_skill(action.skill)
		if bonus > 0:
			bonusLabel.text = 'Bonus: +'+str(bonus)
		else:
			bonusLabel.text = 'Bonus: '+str(bonus)
		bonusLabel.visible = bonus != 0
		var prob = action.get_outcome_probabilities(dice_data) # returning an array might make this cleaner ...
		var p = [
			prob[Enums.EffectClasses.POSITIVE],
			prob[Enums.EffectClasses.NEUTRAL],
			prob[Enums.EffectClasses.NEGATIVE],
		]
		var label = [posLabel,neuLabel,negLabel]
		var prefix = ['Pos: ','Neu: ','Neg: ']
		for i in range(p.size()):
			label[i].text = prefix[i]+str(p[i]*100)+'%'
			label[i].visible = p[i] > 0
		chanceLabels.show()
	else:
		button.text = "Target: " + str(action.target_number)
		chanceLabels.hide()


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
	update_dice_info()
