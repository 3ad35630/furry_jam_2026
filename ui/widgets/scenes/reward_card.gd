extends Control
class_name RewardCard

@export var positiveColor : Color
@export var neutralColor : Color
@export var negativeColor : Color
@export var otherColor : Color

@onready var rewardInfo : Control = $RewardInfo
@onready var clockInfo : Control = $ClockInfo
@onready var clockWidget : ClockWidget = $ClockInfo/ClockWidget
@onready var valueLabel : Label = $RewardInfo/Label
@onready var clockValueLabel : Label = $ClockInfo/ClockWidget/MarginContainer/ConditionLabel
@onready var infoColorRect : ColorRect = $RewardInfo/ColorRect
@onready var clockColorRect : ColorRect = $ClockInfo/ColorRect
@onready var infoLabel : Label = $RewardInfo/InfoLabel
@onready var itemDisplay : ItemDisplay = $RewardInfo/ItemDisplay


func update(valueKey : Enums.EffectClasses, effect : ActionEffect) -> void:
	# update generic info
	var c = otherColor
	match(valueKey):
		Enums.EffectClasses.POSITIVE : c = positiveColor
		Enums.EffectClasses.NEUTRAL : c = neutralColor
		Enums.EffectClasses.NEGATIVE : c = negativeColor
		_ : pass
	infoColorRect.color = c
	clockColorRect.color = c
	valueLabel.modulate = c
	clockValueLabel.modulate = c
	var lab = Enums.EffectClasses.keys()[valueKey]
	valueLabel.text = lab
	clockValueLabel.text = lab
	
	# reset components
	rewardInfo.hide()
	clockWidget.hide()
	
	# update components
	# TODO: un-hard-code the sprite frame values without making the code 30% uglier
	# TODO: figure out how to deal with multiple effects ...
	if effect is AddItem:
		rewardInfo.show()
		var item = Enums.ItemTypes.keys()[effect.item_type]
		infoLabel.text = item + ' (+' + str(effect.amount) + ')'
		itemDisplay.update(effect.item_type)
	elif effect is RemoveItem:
		rewardInfo.show()
		var item = Enums.ItemTypes.keys()[effect.item_type]
		infoLabel.text = item + ' (-' + str(effect.amount) + ')'
		itemDisplay.update(effect.item_type)
	elif effect is TickClock:
		clockWidget.show()
		clockWidget.clock = Locations.clocks[effect.clock_id]
		clockWidget.update(effect.amount)
	elif effect is SetGlobalFlag:
		rewardInfo.show()
		infoLabel.text = effect.key
		itemDisplay.sprite.fame = 15 # cheese wheel
	elif effect is SetLocationFlag:
		rewardInfo.show()
		infoLabel.text = effect.key
		itemDisplay.sprite.frame = 19 # cheese wedge
	elif effect is StoryMoment:
		rewardInfo.show()
		infoLabel.text = effect.key
		itemDisplay.sprite.frame = 8 # pumpkin
	elif effect is MultipleActionEffects:
		rewardInfo.show()
		infoLabel.text = '(multiple)'
		itemDisplay.sprite.frame = 2 # bag
	else:
		rewardInfo.show()
		infoLabel.text = '... idk?'
		itemDisplay.sprite.frame = 5 # shroom
