extends Node2D

signal trigger(limb)
signal trigger_on_body(body)
signal triggered()

func trigger(limb):
	emit_signal("trigger",limb)
	emit_signal("triggered")
	queue_free()

func trigger_on_body(body):
	if !body.is_in_group("player"):
		return
	emit_signal("trigger_on_body",body)
	emit_signal("triggered")
	queue_free()

func handle_hitbox(hitbox) -> void:
	if "limb" in hitbox.owner:
		trigger(hitbox.owner.limb)
	
