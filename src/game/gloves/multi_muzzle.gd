extends Node2D

func shoot():
	for child in get_children():
		child.shoot()
