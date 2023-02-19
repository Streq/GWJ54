extends State
func _physics_update(delta:float):
	var button = root.owner.input_state.get(root.trigger_action)
	var predicate_result = button.call(root.trigger_predicate)
	if predicate_result:
		root.trigger_weapon()
		return
	root.look_at(root.owner.input_state.aim_pos)
func lock():
	goto("disabled")

func unlock():
	pass

func cast():
	goto("casting")

func cast_over():
	pass
