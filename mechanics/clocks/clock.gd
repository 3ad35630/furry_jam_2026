extends Resource
class_name Clock

signal ticked(segments : int)
signal completed(clock : Clock)

@export var clock_id : String
@export var description : String

@export var access_test : AccessTest = null
var accessible : 
	get:
		if complete:
			return false
		if access_test != null:
			return access_test.accessible
		return true

@export var tick_on_round_end : bool = false
@export var max_segments: int
var current_segments : int = 0
@export var effect: ActionEffect

var complete :
	get :
		return current_segments >= max_segments

func tick(amount):
	current_segments += amount
	ticked.emit(current_segments)
	if complete:
		if effect != null:
			effect.do()
		completed.emit(self)

func round_end() -> void:
	if tick_on_round_end:
		tick(1)
		
func subscribe_to_turn_system() -> void:
	TurnSystem.round_ended.connect(round_end)
