extends Node

func _input(event: InputEvent) -> void:
	if "input_state" in get_parent():
		var state = get_parent().input_state
		if event.is_action("A"):
			state.A.pressed = event.is_pressed()
		if event.is_action("B"):
			state.B.pressed = event.is_pressed()

func _physics_process(delta: float) -> void:
	get_parent().input_state.aim_pos = get_parent().get_global_mouse_position()
	get_parent().input_state.dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
