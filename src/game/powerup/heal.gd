extends Node

export var amount := 40.0

func trigger(limb):
	trigger_on_body(limb.owner)


func trigger_on_body(body):
	body.get_node("%health").value += amount
