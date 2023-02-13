extends CharacterState

export var speed := 200.0

func _physics_update(delta: float):
	var dir = root.input_state.dir
	root.velocity = dir*speed
	root.pivot.look_at(root.input_state.aim_pos)

