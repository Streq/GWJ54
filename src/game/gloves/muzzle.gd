extends Node2D
export var PROJECTILE : PackedScene


func shoot():
	var projectile = PROJECTILE.instance()
	owner.wielder.get_parent().add_child(projectile)
	projectile.global_position = global_position
	projectile.global_rotation = 0
	projectile.velocity = global_rotation
