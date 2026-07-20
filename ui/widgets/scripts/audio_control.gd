extends HSlider

@export var audio_bus: String

var audio_bus_id

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index(audio_bus)

func _on_value_changed(in_value: float) -> void:
	var db = linear_to_db(in_value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
