extends Control

const clear = Color(0,0,0,0)
const opaque = Color(1,1,1,1)

@export var toggle_visible : bool = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = clear
	if toggle_visible : hide()
	
func fade_in(duration : float) -> void:
	if toggle_visible : show()
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"modulate", 
		opaque, 
		duration).from(clear)
	await tween.finished

func fade_out(duration : float) -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(
		self,
		"modulate", 
		clear, 
		duration).from(opaque)
	await tween.finished
	if toggle_visible : hide()
