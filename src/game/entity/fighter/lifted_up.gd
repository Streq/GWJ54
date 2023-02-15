extends Node


onready var timer: Timer = $Timer

func trigger():
	get_parent().fly()
	timer.start()
	yield(timer,"timeout")
	get_parent().land()
