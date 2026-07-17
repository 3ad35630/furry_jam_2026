extends Control

## pre-programmed panel positions for each scene
const panelPosition : Dictionary[String,Array] = {
	'test_location_a' : [
		Vector2(888,88),
		Vector2(624,88),
		Vector2(360,88),
	],
	'l_spiritfarm' : [
		Vector2(888,112),
		Vector2(624,88),
		Vector2(360,64),
	],
	'l_docks' : [
		Vector2(888,64),
		Vector2(624,88),
		Vector2(360,112),
	]
}


func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_on_mode_changed)


func _on_mode_changed(mode : Enums.GameplayMode) -> void:
	match(mode):
		Enums.GameplayMode.LOCATION:
			var actions = Modes.current_location.accessible_actions
			assert(actions.size() <= get_child_count())
			for i in range(get_child_count()):
				var panel : ActionPanel = get_child(i)
				if i < actions.size():
					panel.action = actions[i]
					var key = Modes.current_location.location_id
					panel.position = panelPosition[key][i]
					panel.show()
				else:
					panel.hide()
			show()
		_:
			hide()
