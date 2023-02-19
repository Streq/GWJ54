extends Position2D
signal spawn(what)

export var MOB : PackedScene
export var trigger_on_ready := true
export var cancel_on_cleared := true
export var parenthood_level := 0
func _ready() -> void:
	yield(owner,"ready")
	if trigger_on_ready:
		if owner.state.cleared and cancel_on_cleared:
			return
	
		trigger()
	

func trigger():
	var mob = MOB.instance()
	var parent = self
	var i = 0
	while i != parenthood_level:
		i+=1
		parent = parent.get_parent()
	parent.add_child(mob)
	mob.global_position = global_position
	emit_signal("spawn",mob)

