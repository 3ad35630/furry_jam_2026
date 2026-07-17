extends Control
class_name ActionPanel

## not controlled by an ActionManager (only ActionPanel in scene)
## gives access to all Actions in a Location using TAB
@export var noManager : bool = false

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
	if noManager:
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
	if noManager or not active : return
	if event.is_action_pressed("ui_focus_next"): # teb to next available action in location
		var actions = Modes.current_location.accessible_actions
		actionIndex += 1
		if actionIndex >= actions.size():
			actionIndex = 0
		action = Modes.current_location.accessible_actions[actionIndex]


## NOTE: only relevant if not in an ActionManager
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
