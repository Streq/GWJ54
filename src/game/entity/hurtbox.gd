extends Area2D

signal hit()

onready var health: Node = $"%health"

var team setget, get_team

var vertical_position setget, get_vertical_position

func receive_damage(damage):
	health.value-=damage
	emit_signal("hit")

func receive_knockback(direction:Vector2, amount:float, vertical_knockback:float):
	owner.velocity = direction.normalized()*amount
	print (owner.name)
	owner.vertical_velocity = vertical_knockback

func get_team():
	return owner.team

func get_vertical_position():
	return owner.vertical_position
