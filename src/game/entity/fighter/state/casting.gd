extends CharacterState

export var speed := 200.0

var locked_in = false
var locked_feet = false


func _physics_update(delta: float):
	var dir = root.input_state.dir
	root.velocity = dir*speed
