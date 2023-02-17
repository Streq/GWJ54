extends State
func _physics_update(delta:float):
	if root.owner.input_state.get(root.trigger_action).call(root.trigger_predicate):
		root.trigger_weapon()
		return
	if owner.name == "left":
		print("rotating_hand")
	root.look_at(root.owner.input_state.aim_pos)
func lock():
	goto("disabled")

func unlock():
	pass

func cast():
	goto("casting")

func cast_over():
	pass
