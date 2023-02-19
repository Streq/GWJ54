extends Area2D

signal hit()

onready var health: Node = $"%health"

var team setget, get_team

var vertical_position setget, get_vertical_position

export var knockback_factor := 1.0

func receive_damage(damage):
	health.value-=damage
	emit_signal("hit")

func receive_knockback(direction:Vector2, amount:float, vertical_knockback:float):
	owner.velocity = direction.normalized()*amount*knockback_factor
#	print (owner.name)
	owner.vertical_velocity = vertical_knockback*knockback_factor

func get_team():
	return owner.team

func get_vertical_position():
	return owner.vertical_position

func handle_hitbox(hitbox):
	hitbox.affect_hurtbox(self)
