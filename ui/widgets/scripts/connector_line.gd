extends Line2D


## object that the line should point to
@export var target : Node3D
## radius of circle around object
@export var circleRadius : float = 16

var endpoint : Vector2


func _process(delta: float) -> void:
	endpoint = points[0]# TODO: set end point to projection of target onto canvas
	points[1] = endpoint + (points[1]-points[0]).normalized() * circleRadius # don't overlap circle
	# TODO: compute joint positions in line?
	pass
	queue_redraw()


func _draw() -> void:
	draw_circle(endpoint,circleRadius,default_color,false,width,antialiased)
