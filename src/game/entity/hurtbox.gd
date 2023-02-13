extends Area2D
onready var health: Node = $"%health"

var team setget, get_team

func receive_damage(damage):
	health.value-=damage

func receive_knockback(direction:Vector2, amount:float):
	owner.velocity = direction.normalized()*amount

func get_team():
	return owner.team
