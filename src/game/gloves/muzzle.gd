extends Node2D
export var PROJECTILE : PackedScene

export var speed := 200.0
func shoot():
	var projectile = PROJECTILE.instance()
	owner.wielder.get_parent().add_child(projectile)
	projectile.global_position = global_position
	projectile.global_rotation = global_rotation
	projectile.velocity = Vector2.RIGHT.rotated(global_rotation)*speed
	
	projectile.team = owner.team
