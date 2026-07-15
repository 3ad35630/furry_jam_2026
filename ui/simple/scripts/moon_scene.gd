extends Node3D

@export var cameras : Array[Camera3D] = []
#@export var _dock : Location
#@export var _farm : Location
#@export var _woods : Location

func return_to_world():
	for i in range(cameras.size()):
		if cameras[i].current == true:
			CameraTransition.transition_camera(cameras[i], cameras[0], 2.0)

func go_to_docks():
	#cameras[0].clear_current(false)
	#cameras[2].make_current()
	CameraTransition.transition_camera(cameras[0], cameras[2], 2.0)

func go_to_farm():
	#cameras[0].clear_current(false)
	#cameras[1].make_current();
	CameraTransition.transition_camera(cameras[0], cameras[1], 2.0)
	
func go_to_woods():
	#cameras[0].clear_current(false)
	#cameras[3].make_current()
	CameraTransition.transition_camera(cameras[0], cameras[3], 2.0)

func _on_return_button_pressed() -> void:
	$MainPanel/CanvasLayer2.visible = false
	$MainPanel/CanvasLayer.visible = true
	return_to_world()

func _on_woods_button_pressed() -> void:
	$MainPanel/CanvasLayer2.visible = true
	$MainPanel/CanvasLayer.visible = false
	go_to_woods()

func _on_farm_button_pressed() -> void:
	$MainPanel/CanvasLayer2.visible = true
	$MainPanel/CanvasLayer.visible = false
	go_to_farm()

func _on_docks_button_pressed() -> void:
	$MainPanel/CanvasLayer2.visible = true
	$MainPanel/CanvasLayer.visible = false
	go_to_docks()
