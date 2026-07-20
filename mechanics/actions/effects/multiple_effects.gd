extends ActionEffect
class_name MultipleActionEffects

@export var effects : Array[ActionEffect]

func do() -> void:
	for effect in effects:
		effect.do()

func get_result_text() -> Array[String]:
	var result : Array[String] = []
	for effect in effects:
		result.append_array(effect.get_result_text())
	return result
