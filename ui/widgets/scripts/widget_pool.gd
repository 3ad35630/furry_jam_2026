extends Node

@export var widget_class : PackedScene

var active_widgets : Array[Control]
var pool_widgets : Array[Control]

func get_widget_from_pool() -> Control:
	if pool_widgets.is_empty():
		var new_panel = widget_class.instantiate()
		pool_widgets.append(new_panel)
		get_parent().add_child(new_panel)
	var result = pool_widgets.pop_back()
	active_widgets.append(result)
	return result

func return_widget_to_pool(widget : Control) -> void:
	var index = active_widgets.find(widget)
	active_widgets.remove_at(index)
	pool_widgets.append(widget)
	widget.hide()
