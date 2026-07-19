extends DieDisplay
		
@export var draggable : PackedScene
@export var hide_on_drag = true
@export var remove_data_on_failed_drop = false
@export var remove_if_successfully_dragged = false

signal drag_started(display, data)
signal drag_ended(display : DieDisplay, data : Dictionary, success : bool)
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
	drag_started.emit(self, data)
	return data


func _on_drag_started(display: Variant, data: Variant) -> void:
	if hide_on_drag:
		hide()


func _on_drag_ended(display: DieDisplay, data: Dictionary, success: bool) -> void:
	if success:
		if remove_if_successfully_dragged:
			data = {}
	else:
		if remove_data_on_failed_drop:
			data = {}
		elif hide_on_drag:
			show()
