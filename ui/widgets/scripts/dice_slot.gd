extends Control
class_name DiceSlot

@export var display : SimpleDieDisplay

signal data_changed(data)

func _ready() -> void:
	display.data_changed.connect(_on_data_changed)

func update() -> void:
	if display.data.is_empty():
		display.hide()
	else:
		display.show()

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has('die_value')

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	display.data = data

func clear_data() -> void:
	display.data = {}

func has_data() -> bool:
	return not display.data.is_empty()

func _on_data_changed(data : Variant) -> void:
	data_changed.emit(data)
	update()
