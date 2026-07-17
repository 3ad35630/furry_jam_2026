extends PanelContainer

## number of non-clocks at the start of the container

@onready var button : Button = $MarginContainer/ButtonContainer/Button
@onready var clockContainer : VBoxContainer = $MarginContainer/VBoxContainer/ClockList/ClockContainer
@onready var clockList : VBoxContainer = $MarginContainer/VBoxContainer/ClockList


func _ready() -> void:
	button.pressed.connect(_toggle_clocks)
	Modes.gameplay_mode_changed.connect(_on_mode_changed)


func _toggle_clocks() -> void:
	clockList.visible = not clockList.visible


func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	#clockList.hide()
	
	# get relevant clocks
	var clocks : Array[Clock] = []
	match(mode):
		Enums.GameplayMode.LOCATION:
			clocks = Modes.current_location.accessible_clocks
		Enums.GameplayMode.MAP:
			# TODO: get all clocks in Map view
			pass
	
	if clocks.is_empty():
		clockList.hide()
		button.disabled = true
	else:
		button.disabled = false
		
		# add more widgets if necessary
		var delta = clocks.size() - clockContainer.get_child_count()
		if delta > 0:
			var template = clockContainer.get_child(0)
			for i in range(delta):
				var newWidget = template.duplicate()
				clockContainer.add_child(newWidget)
	
		# update widgets
		for i in range(clockContainer.get_child_count()):
			var widget = clockContainer.get_child(i)
			if i < clocks.size():
				widget.show()
				widget.clock = clocks[i]
			else:
				widget.hide()
