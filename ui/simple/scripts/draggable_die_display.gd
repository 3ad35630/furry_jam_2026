extends SimpleDieDisplay
		
@export var draggable : PackedScene
signal drag_ended(display : SimpleDieDisplay, data : Dictionary, success : bool)
var is_dragging : bool = false

func _notification(notification_type):
	if is_dragging and notification_type == NOTIFICATION_DRAG_END:
		is_dragging = false
		drag_ended.emit(self, data, is_drag_successful())

func _get_drag_data(_at_position: Vector2) -> Variant:
	var drag_display = draggable.instantiate()
	drag_display.data = data
	set_drag_preview(drag_display)
	is_dragging = true
	return data
