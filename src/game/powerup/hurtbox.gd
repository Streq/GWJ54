extends Area2D

var team = -1000
var vertical_position = 0.0
signal hitbox(hitbox)


func handle_hitbox(hitbox):
	emit_signal("hitbox",hitbox)
