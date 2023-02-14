extends State
func _physics_update(delta:float):
	root.look_at(root.owner.input_state.aim_pos)
	if root.owner.input_state.get(root.trigger_action).call(root.trigger_predicate):
		root.trigger_weapon()

func lock():
	goto("disabled")

func unlock():
	pass

func cast():
	goto("casting")

func cast_over():
	pass
