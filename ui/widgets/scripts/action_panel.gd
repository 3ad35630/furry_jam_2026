extends Control
class_name ActionPanel

signal action_set(action : Action)

var _action : Action
var action : Action :
	set(new):
		_action = new
		action_set.emit(new)
	get:
		return _action
