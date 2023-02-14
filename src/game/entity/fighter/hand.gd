extends Node2D
signal cast()
signal cast_over()

signal lock_aim()
signal unlock_aim()

signal lock_limbs()
signal unlock_limbs()

signal lock_feet()
signal unlock_feet()

export var trigger_action := "A"
export var trigger_predicate := "is_just_pressed"


var weapon : Weapon = null
onready var state_machine: Node = $"%state_machine"


func _ready() -> void:
	state_machine.initialize()

func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	
func add_weapon(new_weapon):
	if is_instance_valid(weapon):
		remove_child(weapon)
		weapon.disconnect("cast",self,"_on_cast")
		weapon.disconnect("cast_over",self,"_on_cast_over")
		for signal_name in [
			"lock_feet",
			"unlock_feet",
			"lock_limbs",
			"unlock_limbs",
			"lock_aim",
			"unlock_aim"
		]:
			undo_forward_signal(weapon, signal_name)
		
		weapon.queue_free()
	
	weapon = new_weapon
	NodeUtils.add_or_reparent(weapon, self)
	
	weapon.connect("cast",self,"_on_cast")
	weapon.connect("cast_over",self,"_on_cast_over")
	
	for signal_name in [
		"lock_feet",
		"unlock_feet",
		"lock_limbs",
		"unlock_limbs",
		"lock_aim",
		"unlock_aim"
	]:
		forward_signal(weapon, signal_name)
	
	weapon.wielder = owner
	

func forward_signal(object, signal_name):
	object.connect(signal_name,self,"emit_signal",[signal_name])

func undo_forward_signal(object, signal_name):
	object.disconnect(signal_name,self,"emit_signal",[signal_name])

func _on_cast():
	state_machine._change_state("casting")
	emit_signal("cast")

func _on_cast_over():
	state_machine._change_state("idle")
	emit_signal("cast_over")

func lock():
	state_machine._change_state("disabled")

func unlock():
	state_machine._change_state("idle")

func disable():
	state_machine._change_state("disabled")

func trigger_weapon():
	if is_instance_valid(weapon):
		weapon.cast()
