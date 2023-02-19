extends Node
signal trigger
export var chance := 1.0

func trigger():
	if randf() < chance:
		emit_signal("trigger")
	
	pass 
