extends Node3D

@onready var fish = $FishLake
@onready var mill = $WindMill
@onready var cow1 = $"Soul Cow_001"
@onready var cow2 = $"Soul Cow_002"
@onready var festival_sign = $NoEntrySign
@onready var shrine = $OtterShrineBroken

@export var farm_clock: String = "awaken_the_cows"
@export var sign_clock: String = "kicked_out_of_the_festival"
@export var shrine_clock: String = "shrine_repairs"
@export var fish_speed: float = -0.5
@export var mill_speed: float = 1.0

func _ready() -> void:
	Locations.clocks[farm_clock].completed.connect(farm_completed)
	Locations.clocks[sign_clock].completed.connect(sign_completed)
	Locations.clocks[shrine_clock].completed.connect(shrine_completed)

func _process(delta: float) -> void:
	fish.rotation.z = deg_to_rad(rad_to_deg(fish.rotation.z) + (fish_speed * delta))
	mill.rotation.z = deg_to_rad(rad_to_deg(mill.rotation.z) + (mill_speed * delta))

func farm_completed(_clock) -> void:
	cow1.show()
	cow2.show()

func sign_completed(_clock) -> void:
	festival_sign.show()
	
func shrine_completed(_clock) -> void:
	shrine.hide()
