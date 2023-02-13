extends KinematicBody2D
onready var pivot: Node2D = $pivot

export var speed := 100.0

export var team := 0

var velocity := Vector2()

var punching = false
var locked_in = false
func _physics_process(delta: float) -> void:
	var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = dir*speed
	velocity = move_and_slide(velocity)
	if !locked_in:
		pivot.global_rotation = lerp_angle(pivot.global_rotation,get_global_mouse_position().angle_to_point(global_position),delta*10.0)
