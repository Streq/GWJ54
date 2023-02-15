extends CharacterState

export var speed := 200.0


export var damping := 10.0
func _physics_update(delta: float):
	if root.is_on_floor():
		root.velocity *= 1-(damping*delta)
	
