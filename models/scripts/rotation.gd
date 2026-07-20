extends Node3D

@onready var fish = $FishLake
@onready var mill = $WindMill
@onready var cow1 = $"Soul Cow_001"
@onready var cow2 = $"Soul Cow_002"

@export var farm_clock: String
@export var fish_speed: float = -0.5
@export var mill_speed: float = 1.0

func _ready() -> void:
	Locations.clocks[farm_clock].completed.connect(farm_completed)

func _process(delta: float) -> void:
	fish.rotation.z = deg_to_rad(rad_to_deg(fish.rotation.z) + fish_speed)
	mill.rotation.z = deg_to_rad(rad_to_deg(mill.rotation.z) + mill_speed)

func farm_completed() -> void:
	cow1.show()
	cow2.show()
