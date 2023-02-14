extends CharacterState

export var speed := 200.0

onready var limbs = $"%limbs"

var locked_aim = 0
var locked_feet = 0
var locked_limbs = 0

func _exit():
	locked_aim = 0
	locked_feet = 0
	unlock_limbs()

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
	if !locked_feet:
		var dir = root.input_state.dir
		root.velocity = dir*speed
	if !locked_aim:
		var aim_pos = root.input_state.aim_pos
#		root.pivot.look_at(aim_pos)
		var target_angle = aim_pos.angle_to_point(root.global_position)
		root.pivot.global_rotation = lerp_angle(root.pivot.global_rotation, target_angle, delta*10.0)

func lock_aim():
	locked_aim += 1
func unlock_aim():
	locked_aim  -= 1
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

	
