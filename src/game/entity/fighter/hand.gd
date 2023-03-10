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

var vertical_position setget, get_vertical_position

onready var state_machine: Node = $"%state_machine"

var locked_aim = false


export var can_aim_while_attacking := false
export var start_lag_factor := 1.0
export var finish_lag_factor := 1.0
export var damage_factor := 1.0
export var reach_factor := 1.0
export var speed_factor := 1.0
export var knockback_factor := 1.0
export var punch_again_factor := 1.0

func _ready() -> void:
	state_machine.initialize()

func _physics_update(delta: float) -> void:
	state_machine.physics_update(delta)
	
	
func remove_weapon():
	remove_child(weapon)
	for signal_name in [
		"cast",
		"cast_over",
	]:
		weapon.disconnect(signal_name, self, signal_name)
	
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
	$bare_sprite.show()
func add_weapon(new_weapon):
	if is_instance_valid(weapon):
		remove_weapon()
	weapon = new_weapon
	owner.connect("despawned",weapon,"queue_free")
	NodeUtils.add_or_reparent(weapon, self)
	
	
	for signal_name in [
		"cast",
		"cast_over",
	]:
		weapon.connect(signal_name, self, signal_name)
	
	for signal_name in [
		"lock_feet",
		"unlock_feet",
		"lock_limbs",
		"unlock_limbs",
		"lock_aim",
		"unlock_aim"
	]:
		forward_signal(weapon, signal_name)
	var material_to_use = material if material else owner.material
	weapon.material = material_to_use
	weapon.wielder = owner
	weapon.limb = self
	weapon.use_parent_material = false
	$bare_sprite.hide()
	

func forward_signal(object, signal_name):
	object.connect(signal_name,self,"emit_signal",[signal_name])

func undo_forward_signal(object, signal_name):
	object.disconnect(signal_name,self,"emit_signal",[signal_name])

func cast():
	state_machine.current.cast()
	emit_signal("cast")

func cast_over():
	state_machine.current.cast_over()
	emit_signal("cast_over")

func lock_aim():
	locked_aim = true and !can_aim_while_attacking
func unlock_aim():
	locked_aim = false


func lock():
	state_machine.current.lock()

func unlock():
	state_machine.current.unlock()

func trigger_weapon():
	if is_instance_valid(weapon):
		weapon.cast()

func get_vertical_position():
	return owner.vertical_position
