extends AudioStreamPlayer

@export var world_audio: AudioStream

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_location_music)
	
func _location_music(mode : Enums.GameplayMode) -> void:
	if mode == Enums.GameplayMode.LOCATION and Modes.current_location.audio != null:
		stop()
		set_stream(Modes.current_location.audio)
		play()
	if mode == Enums.GameplayMode.MAP:
		stop()
		set_stream(world_audio)
		play()
