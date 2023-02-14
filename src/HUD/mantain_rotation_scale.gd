extends Node2D

func _process(delta):
	var aux_pos = position
	global_transform = Transform2D.IDENTITY
	position = aux_pos
	
	
