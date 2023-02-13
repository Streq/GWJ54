extends KinematicBody2D

var velocity := Vector2()

export var damping := 1.0
export var team := 1.0

func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity)
	velocity *= 1-damping*delta
