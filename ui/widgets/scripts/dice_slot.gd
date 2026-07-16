extends Control
class_name DiceSlot

@onready var display : SimpleDieDisplay = $CenterContainer/DieDisplay
@onready var target : Control = $MarginContainer/ColorRect


func _ready() -> void:
	display.data_changed.connect(_on_data_changed)

func update() -> void:
	display.visible = not display.data.is_empty()

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return typeof(data) == TYPE_DICTIONARY and data.has('die_value')

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	display.data = data

func clear_data() -> void:
	display.data = {}

func has_data() -> bool:
	return not display.data.is_empty()

func _on_data_changed(data : Variant) -> void:
	display.visible = typeof(data) == TYPE_DICTIONARY and not data.is_empty()
