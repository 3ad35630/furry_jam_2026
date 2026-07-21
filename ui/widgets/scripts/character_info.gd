extends Control

@export var offset : Vector2 = Vector2(0,-150)
@export var nameLabel : Label
#@export var textLabel : Label
@export var skillLabels : VBoxContainer

## use control nodes as mouse sensors; display info for a particular witch
## when the mouse is hovering over that node
@export var sensors : Dictionary[Control,Character]


func _ready() -> void:
	for node : Control in sensors.keys():
		node.mouse_entered.connect(set_witch.bind(node))
		node.mouse_exited.connect(hide)


func set_witch(node : Control) -> void:
	show()
	var witch : Character = sensors[node]
	var delta = (node.size.x - size.x) / 2
	global_position = node.global_position + offset + Vector2.RIGHT * delta
	nameLabel.text = witch.name + ' - Skills'
	#textLabel.text = witch.description
	var keys = witch.skills.keys()
	for i in range(skillLabels.get_child_count()): # not easily scalable, but works for now
		var lab = skillLabels.get_child(i)
		if i < keys.size():
			var skill = Enums.Skills.keys()[keys[i]].to_lower()
			var value = witch.skills[keys[i]]
			var prefix = '+' if value >= 0 else ''
			lab.text = skill + ': ' + prefix + str(value)
			lab.show()
		else:
			lab.hide()
