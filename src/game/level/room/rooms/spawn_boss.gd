extends Node2D
signal spawn(what)

export var trigger_on_ready := true
export var cancel_on_cleared := true
export var trigger_on_cleared_only := false


func _ready() -> void:
	yield(owner,"ready")
	if trigger_on_ready:
		if owner.state.cleared and cancel_on_cleared:
			return
#		if !owner.state.cleared and trigger_on_cleared_only:
#			return
		trigger()
	
	

func trigger():
	if owner.state.item_taken:
		return
	var strid : String = owner.get_parent().current_room_cell()
	var ids = strid.substr(1).split(",")
	var powerup_id = int(ids[0])
	var boss_id = int(ids[1])
	
	var MOB = RoomPool.boss_pool[boss_id]
	var mob = MOB.instance()
	add_child(mob)
	emit_signal("spawn",mob)
	mob.connect("trigger",self,"_on_reward_taken")

func _on_reward_taken(limb):
	owner.state.item_taken = true
