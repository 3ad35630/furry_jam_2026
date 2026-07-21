extends Node

@onready var global = $Global_Music
@onready var location = $Location_Music
@onready var animation = $AnimationPlayer

@export var world_audio: AudioStream
@export var menu_audio: AudioStream

func _ready() -> void:
	Modes.gameplay_mode_changed.connect(_location_music)
	
func _location_music(mode : Enums.GameplayMode) -> void:
	if mode == Enums.GameplayMode.LOCATION and Modes.current_location.audio != null:
		if !global.playing:
			crossfade_to(Modes.current_location.audio)
	if mode == Enums.GameplayMode.MAP:
		if !location.playing:
			crossfade_to(world_audio)
	if mode == Enums.GameplayMode.MAINMENU:
		global.stop()
		location.stop()
		$"../MainMenu/MuchAdoAboutTea".play()

func crossfade_to(audio: AudioStream) -> void:
	if global.playing and location.playing:
		return
		
	if location.playing:
		global.stream = audio
		global.play()
		animation.play("Location_to_Global")
	else:
		location.stream = audio
		location.play()
		animation.play("Global_to_Location")
