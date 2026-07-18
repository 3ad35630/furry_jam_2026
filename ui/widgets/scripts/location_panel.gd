extends PanelContainer

## number of non-clocks at the start of the container

@export var infoButton : Button
@export var clockButton : Button
@export var infoContainer : Control
@export var clockContainer : Control
@export var clockList : VBoxContainer
@export var infoLabel : Label


func _ready() -> void:
	infoButton.toggled.connect(_show_info)
	clockButton.toggled.connect(_show_clocks)
	Modes.gameplay_mode_changed.connect(_on_mode_changed)


func _show_info(state : bool = true) -> void:
	infoContainer.visible = state
	infoButton.button_pressed = state


func _show_clocks(state : bool = true) -> void:
	clockContainer.visible = state
	clockButton.button_pressed = state


func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	_show_clocks(true)
	_show_info(false)
	
	# get relevant clocks and set location-dependent data
	var clocks : Array[Clock] = []
	match(mode):
		Enums.GameplayMode.LOCATION:
			infoLabel.text = Modes.current_location.description
			clocks = Modes.current_location.accessible_clocks
		Enums.GameplayMode.MAP:
			# TODO: put this text somewhere sensible
			infoLabel.text = 'Objective: You gotta go get those ingredients and bring them back to Mme. Oolong, critters!'
			clocks = Locations.accessible_clocks
	
	if clocks.is_empty():
		#_show_clocks(false)
		clockButton.disabled = true
	else:
		clockButton.disabled = false
		
		# add more widgets if necessary
		var delta = clocks.size() - clockList.get_child_count()
		if delta > 0:
			var template = clockList.get_child(0)
			for i in range(delta):
				var newWidget = template.duplicate()
				clockList.add_child(newWidget)
	
		# update widgets
		for i in range(clockList.get_child_count()):
			var widget = clockList.get_child(i)
			if i < clocks.size():
				widget.show()
				widget.clock = clocks[i]
			else:
				widget.hide()
