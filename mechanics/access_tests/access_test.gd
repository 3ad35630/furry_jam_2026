extends Resource
class_name AccessTest

var accessible :
	get :
		return _is_accessible()

func _is_accessible() -> bool:
	return true
