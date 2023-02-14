extends State

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
