extends InkPlayer

var should_return_to_game : bool : 
	get :
		return not (has_choices or can_continue)

func _ready() -> void:
	ink_file = load("res://resources/story/story.json")
	connect("loaded",_on_loaded)
	create_story()

func _input(event) -> void:
	if Modes.current_mode == Enums.GameplayMode.NARRATIVE:
		if event.is_action_pressed('advance_narrative'):
			advance_narrative()

func _on_loaded(_successfully: Variant) -> void:
	pass

func start_narrative(path : String) -> void:
	Modes.change_gameplay_mode(Enums.GameplayMode.NARRATIVE)
	choose_path(path)
	advance_narrative()
	
func advance_narrative():
	if should_return_to_game:
		Modes.change_gameplay_mode(Modes.previous_mode)
	if can_continue:
		continue_story()
