extends ActionEffect
class_name MultipleActionEffects

@export var effects : Array[ActionEffect]

func do() -> void:
	for effect in effects:
		effect.do()
