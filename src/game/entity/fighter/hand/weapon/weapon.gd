extends Node2D
class_name Weapon

signal cast()
signal cast_over()
signal lock_aim()
signal unlock_aim()
signal lock_feet()
signal unlock_feet()
signal lock_limbs()
signal unlock_limbs()

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
func lock_feet():
	emit_signal("lock_feet")
func unlock_feet():
	emit_signal("unlock_feet")
func lock_limbs():
	emit_signal("lock_limbs")
func unlock_limbs():
	emit_signal("unlock_limbs")
