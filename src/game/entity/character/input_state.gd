extends Node


var A := ButtonState.new()
var B := ButtonState.new()
var C := ButtonState.new()
var dir := Vector2() setget set_dir
var aim_pos := Vector2()

func set_dir(val:Vector2):
	dir = val.limit_length()
	

func _physics_process(delta: float) -> void:
	if owner.name == "zombie":
		pass
	A.stale()
	B.stale()
	C.stale()

func clear():
	A.stale()
	B.stale()
	C.stale()
	dir = Vector2()
	aim_pos = Vector2()

func get_aim_dir() -> Vector2:
	return owner.global_position.direction_to(aim_pos)
