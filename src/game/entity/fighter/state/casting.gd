extends CharacterState

export var acceleration := 20.0

export var damping := 0.0

onready var limbs = $"%limbs"

var locked_aim = 0
var locked_feet = 0
var locked_limbs = 0

func _exit():
	pass

func _ready():
	update_limb_connections()

func update_limb_connections():
	for limb in limbs.get_children():
		observe(limb)

func observe(limb:Node):
	for signal_name in [
		"lock_feet",
		"unlock_feet",
		"lock_limbs",
		"unlock_limbs",
		"lock_aim",
		"unlock_aim",
		"cast_over"
	]:
		limb.connect(signal_name, self, signal_name)



func _physics_update(delta: float):
	if root.is_on_floor():
		root.velocity *= 1-(damping*delta)
		
		if !locked_feet:
			var dir = root.input_state.dir
			root.velocity = root.velocity.linear_interpolate(dir*root.speed,acceleration*delta)
	

	
	if !locked_aim:
#		root.pivot.look_at(aim_pos)

		print("rotating_body")
		root.pivot.global_rotation = lerp_angle(root.pivot.global_rotation, root.input_state.get_aim_dir().angle(), delta*10.0)
	_physics_update_limbs(delta)


func _physics_update_limbs(delta:float):
	for limb in limbs.get_children():
		limb._physics_update(delta)

func lock_aim():
	locked_aim += 1
	if locked_aim:
		lock_aim_in_limbs()

func unlock_aim():
	locked_aim  -= 1
	if !locked_aim:
		unlock_aim_in_limbs()
func lock_feet():
	locked_feet += 1
func unlock_feet():
	locked_feet -= 1

func cast_over():
	pass

func lock_limbs():
	locked_limbs += 1
	if locked_limbs:
		_lock_limbs()

func _lock_limbs():
	for limb in limbs.get_children():
		limb.lock()

func unlock_limbs():
	locked_limbs = max(locked_limbs-1,0)
	if !locked_limbs:
		_unlock_limbs()
		
func _unlock_limbs():
	for limb in limbs.get_children():
		limb.unlock()

func lock_aim_in_limbs():
	for limb in limbs.get_children():
		limb.lock_aim()

func unlock_aim_in_limbs():
	for limb in limbs.get_children():
		limb.unlock_aim()
