extends Node2D
signal casting_full_body
signal casting_both_hands
signal casting
signal cast_over


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
		weapon.disconnect("cast_full_body",self,"_on_cast_full_body")
		weapon.disconnect("cast_both_hands",self,"_on_cast_both_hands")
		weapon.disconnect("cast_over",self,"_on_cast_over")
		weapon.queue_free()
	
	weapon = new_weapon
	NodeUtils.add_or_reparent(weapon, self)
	weapon.connect("cast",self,"_on_cast")
	weapon.connect("cast_full_body",self,"_on_cast_full_body")
	weapon.connect("cast_both_hands",self,"_on_cast_both_hands")
	weapon.connect("cast_over",self,"_on_cast_over")
	weapon.wielder = owner
	

func _on_cast():
	state_machine._change_state("casting")
	emit_signal("casting")

func _on_cast_full_body():
	state_machine._change_state("casting")
	emit_signal("casting_full_body")
	
func _on_cast_both_hands():
	state_machine._change_state("casting")
	emit_signal("casting_both_hands")

func _on_cast_over():
	state_machine._change_state("idle")
	emit_signal("cast_over")

func disable():
	state_machine._change_state("disabled")


func trigger_weapon():
	if is_instance_valid(weapon):
		weapon.cast()
