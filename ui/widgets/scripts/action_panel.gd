extends Control

signal skill_die_removed(data)

@onready var infoPanel : ActionPanelInfo = $ActionPanelInfo
@onready var skillPanel : ActionPanelSkill = $ActionPanelSkill
@onready var itemPanel : ActionPanelItem = $ActionPanelItem

var _action : Action
var action : Action :
	set(new):
		_action = new
		update()
	get:
		return _action
var active : bool = false
var actionIndex : int = 0


func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_gameplay_mode_changed)


func update():
	infoPanel.update(action)
	if action is SkillAction:
		itemPanel.hide()
		skillPanel.show()
		skillPanel.update(action)
	elif action is ItemAction:
		skillPanel.hide()
		itemPanel.show()
		itemPanel.update(action)


func _input(event: InputEvent) -> void:
	if not active : return
	if event.is_action_pressed("ui_focus_next"): # teb to next available action in location
		var actions = Modes.current_location.accessible_actions
		actionIndex += 1
		if actionIndex >= actions.size():
			actionIndex = 0
		action = Modes.current_location.accessible_actions[actionIndex]


## NOTE: May want to move function to an ActionManagerPanel if we have multiple ActionPanels
func _on_gameplay_mode_changed(mode : Enums.GameplayMode) -> void:
	actionIndex = 0
	match(mode):
		Enums.GameplayMode.LOCATION:
			var actions = Modes.current_location.accessible_actions
			if actions.size() > 0:
				active = true
				show()
				action = Modes.current_location.accessible_actions[actionIndex]
			else:
				active = false
				hide()
		_:
			active = false
			hide()
