extends State

func _enter(params):
	if owner.name == "left":
		print("disabled_hand")

func lock():
	pass

func unlock():
	goto("idle")

func cast():
	pass

func cast_over():
	pass
