extends Node2D

var velocity := Vector2()
var team := 0
var vertical_position := 0.0

var caster = null
func _physics_process(delta: float) -> void:
	global_position += velocity*delta
