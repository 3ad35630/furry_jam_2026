extends Control

@export var action_panels : Node
@export var clock_panels : Node

var panel_positions : Array[Vector2]
var available_panel_positions : Array
var clock_positions : Array[Vector2]
var available_clock_positions : Array

func get_visible_actions() -> Array:
	var result = []
	for panel in action_panels.active_widgets:
		result.append(panel.action)
	return result

func get_visible_clocks() -> Array:
	var result = []
	for panel in clock_panels.active_widgets:
		result.append(panel.clock)
	return result


func show_action(action) -> void:
	assert(available_panel_positions.size() > 0)
	var panel = action_panels.get_widget_from_pool()
	panel.action = action
	panel.position_index = available_panel_positions.pop_front()
	set_widget_position(panel, panel_positions[panel.position_index])
	panel.set_position(panel_positions[panel.position_index])
	panel.action.connect("action_done", update_panels)
	panel.show()

func set_widget_position(widget, pos) -> void:
	widget.position = Vector2(pos.x-(widget.size.x/2), pos.y-(widget.size.y/2))

func show_clock(clock) -> void:
	assert(available_clock_positions.size() > 0)
	var panel = clock_panels.get_widget_from_pool()
	panel.clock = clock
	panel.position_index = available_clock_positions.pop_front()
	set_widget_position(panel, clock_positions[panel.position_index])
	panel.clock.connect("completed", update_panels)
	panel.show()	

func return_action(panel : ActionPanel) -> void:
	panel.action.disconnect("action_done", update_panels)
	available_panel_positions.insert(0, panel.position_index)
	action_panels.return_widget_to_pool(panel)

func return_clock(panel : ClockWidget) -> void:
	panel.clock.disconnect("completed", update_panels)
	available_clock_positions.insert(0,panel.position_index)
	clock_panels.return_widget_to_pool(panel)

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)

func update_panels() -> void:
	var actions = Modes.current_location.accessible_actions
	for panel in action_panels.active_widgets: # have we lost an action?
		if not panel.action in actions:
			return_action(panel)
	var pa = get_visible_actions()
	for action in actions:
		if not action in pa:
			show_action(action)
	var clocks = Modes.current_location.accessible_clocks
	for panel in clock_panels.active_widgets: # have we lost an action?
		if not panel.clock in clocks:
			return_clock(panel)
	var pc = get_visible_clocks()
	for clock in clocks:
		if not clock in pc:
			show_clock(clock)
			
func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	match(mode):
		Enums.GameplayMode.LOCATION:
			var location_camera = get_viewport().get_camera_3d().current_location_camera
			panel_positions = []
			for pt in location_camera.panel_targets:
				panel_positions.append(pt.screen_position)
			clock_positions = []
			for ct in location_camera.clock_targets:
				clock_positions.append(ct.screen_position)
			available_panel_positions = range(panel_positions.size())
			available_clock_positions = range(clock_positions.size())
			update_panels()
			show()
		_:
			for panel in action_panels.active_widgets:
				return_action(panel)
			hide()
				
