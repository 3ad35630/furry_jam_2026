extends ActionEffect
class_name SetGlobalFlag

@export var key : String
@export var value : bool = true

func do() -> void:
	ScratchPad.set_data(key, value)
