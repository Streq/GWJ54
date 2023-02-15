extends Node2D

func _ready():
	queue_free()

func _process(delta):
	var aux_pos = position
	global_transform = Transform2D.IDENTITY
	position = aux_pos
	
	
