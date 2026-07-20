extends ActionEffect
class_name ResultDescription

@export var text : String

func get_result_text() -> Array[String]:
	if text:
		return [text]
	else:
		return []
