extends Node2D


func _physics_process(delta: float) -> void:
	get_parent().input_state.A.press()
	get_parent().input_state.B.press()
	
	var target = Group.get_one("player")
	if is_instance_valid(target):
		get_parent().input_state.dir = global_position.direction_to(target.global_position)
		get_parent().input_state.aim_pos = target.global_position
