extends Button
class_name MainMenuButton

@export var scaleLimits : Vector2 = Vector2(1,1.25)
@export var tweenTime : float = 0.1


func _ready() -> void:
	scale = Vector2(scaleLimits[0],scaleLimits[0])
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_press)
	Modes.gameplay_mode_changed.connect(_on_mode_changed)


func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"scale",Vector2(scaleLimits[1],scaleLimits[1]),tweenTime)


func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"scale",Vector2(scaleLimits[0],scaleLimits[0]),tweenTime)


#region ----- Overridable Functions -----

func _on_press() -> void:
	pass


func _on_mode_changed(_mode : Enums.GameplayMode) -> void:
	pass

#endregion
