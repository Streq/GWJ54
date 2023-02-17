extends State
func _physics_update(delta):
	if !root.locked_aim:
		root.look_at(root.owner.input_state.aim_pos)

var locked = false

func lock():
	locked = true

func unlock():
	locked = false

func cast():
	pass

func cast_over():
	if locked:
		goto("disabled")
	else:
		goto("idle")
