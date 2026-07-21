extends Node

signal drag_changed(is_dragging : bool)

func start_dragging():
	drag_changed.emit(true)
	
func stop_dragging():
	drag_changed.emit(false)
