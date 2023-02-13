extends Node2D
class_name Weapon

signal cast_full_body()
signal cast_both_hands()
signal cast()
signal lock_aim()
signal unlock_aim()
signal cast_over()

func full_body_cast():
	emit_signal("full_body_cast")

func cast():
	emit_signal("cast")
	_cast()
	
func _cast():
	pass

func cast_over():
	emit_signal("cast_over")

func lock_aim():
	emit_signal("lock_aim")
func unlock_aim():
	emit_signal("unlock_aim")
