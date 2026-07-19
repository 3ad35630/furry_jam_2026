extends Control
class_name ClockWidget

signal clock_ticked(clock : Clock)
signal on_clock_changed(clock : Clock)
#
#@export var bg_color : StyleBoxFlat
#@export var fill_color : StyleBoxFlat
#@export var reward_color : StyleBoxFlat
#@export var penalty_color : StyleBoxFlat

#@export_subgroup("Nodes")
@export var title_label : Label
@export var button : Control
@export var title_label_info : Label
@export var description_label : Label
#@export var segment_container : HBoxContainer
@export var infoPanel : Control

var _clock : String
var clock : Clock :
	set(val) :
		if _clock:
			Locations.clocks[_clock].ticked.disconnect(on_clock_ticked)
		if val:
			_clock = val.clock_id
			Locations.clocks[_clock].ticked.connect(on_clock_ticked)
			on_clock_changed.emit(Locations.clocks[_clock])
			update()
		else:
			_clock = ""
			on_clock_changed.emit(null)
	get :
		if _clock:
			return Locations.clocks[_clock]
		else:
			return null

var segment_displays : Array[PanelContainer]


func _ready() -> void:
	button.mouse_entered.connect(_show_info.bind(true))
	button.mouse_exited.connect(_show_info.bind(false))
	Modes.gameplay_mode_changed.connect(_on_mode_changed)


func _on_mode_changed(_mode : Enums.GameplayMode) -> void:
	_show_info(false)


func _show_info(state : bool = true) -> void:
	infoPanel.visible = state


func on_clock_ticked(_segment : int) -> void:
	update()
	clock_ticked.emit(clock)


func update(_rewardSegs : int = 0) -> void:
	# update labels
	title_label.text = clock.resource_name
	title_label_info.text = clock.resource_name
	description_label.text = clock.description
	#
	## add new segments if necessary
	#var delta = clock.max_segments - segment_container.get_child_count()
	#if delta > 0:
		#var template = segment_container.get_child(0)
		#for i in range(delta):
			#var newSeg = template.duplicate()
			#segment_container.add_child(newSeg)
	#
	## update segment states
	#for x in range(segment_container.get_child_count()):
		#var seg = segment_container.get_child(x)
		#var c = bg_color
		#seg.show()
		#if x < clock.current_segments and x >= clock.current_segments + rewardSegs:
			#c = penalty_color
		#elif x < clock.current_segments:
			#c = fill_color
		#elif x < clock.max_segments and x < clock.current_segments + rewardSegs:
			#c = reward_color
		#elif x < clock.max_segments:
			#pass
		#else:
			#seg.hide()
		#seg['theme_override_styles/panel'] = c
