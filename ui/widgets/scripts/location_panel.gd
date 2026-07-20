extends Control

var action_widgets : Array[ActionPanel]
var clock_widgets : Array[ClockWidget]
var used_action_widgets : Array[ActionPanel]
var used_clock_widgets : Array[ClockWidget]

var visible_actions :
	get:
		var result = []
		for widget in used_action_widgets:
			result.append(widget.action)
		return result

var visible_clocks :
	get:
		var result = []
		for widget in used_clock_widgets:
			result.append(widget.clock)
		return result

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)
	for action in Modes.current_location.actions:
		action.action_done.connect(update_display)
	for clock in Modes.current_location.clocks:
		clock.completed.connect(update_display)
	for child in get_children():
		if child is ActionPanel:
			action_widgets.append(child)
		if child is ClockWidget:
			clock_widgets.append(child)
		child.hide()
	update_display()

func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	if mode != Enums.GameplayMode.LOCATION:
		queue_free()

func next_widget(all, used):
	for widget in all:
		if not widget in used:
			return widget

func update_display(_clock = null) -> void:
	if Modes.current_location:
		update_actions()
		update_clocks()
	
func update_actions() -> void:
	var actions = Modes.current_location.accessible_actions
	for panel in used_action_widgets: # have we lost an action?
		if not panel.action in actions:
			panel.action = null
			used_action_widgets.remove_at(used_action_widgets.find(panel))
			panel.hide()
	var va = visible_actions
	for action in actions:
		if not action in va:
			var next_available = next_widget(action_widgets, used_action_widgets)
			assert(next_available != null)
			used_action_widgets.append(next_available)
			next_available.action = action
			next_available.show()
	
func update_clocks() -> void:
	#var accessible_clocks = Modes.current_location.accessible_clocks
	# if this works im going to be mad
	var accessible_clocks = []
	for clock in Modes.current_location.accessible_clocks:
		accessible_clocks.append(Locations.clocks[clock.clock_id])
	for panel in used_clock_widgets: # have we lost an action?
		if not panel.clock in accessible_clocks:
			panel.clock = null
			used_clock_widgets.remove_at(used_clock_widgets.find(panel))
			panel.hide()
	var vc = visible_clocks
	for clock in accessible_clocks:
		if not clock in vc:
			var next_available = next_widget(clock_widgets, used_clock_widgets)
			assert(next_available != null)
			used_clock_widgets.append(next_available)
			next_available.clock = clock
			next_available.show()
