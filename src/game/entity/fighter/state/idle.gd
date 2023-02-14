extends CharacterState

export var speed := 200.0
onready var limbs = $"%limbs"

func _physics_update(delta: float):
	var dir = root.input_state.dir
	var aim_pos = root.input_state.aim_pos
	root.velocity = dir*speed
	root.pivot.look_at(aim_pos)

func _ready():
	update_limb_connections()

func update_limb_connections():
	for limb in limbs.get_children():
		observe(limb)

func observe(limb:Node):
	for signal_name in [
		"cast",
	]:
		limb.connect(signal_name, self, signal_name)

func cast():
	goto("casting")
