extends Position2D


export var MOB : PackedScene

func _ready() -> void:
	yield(owner,"ready")
	if owner.state.cleared:
		return
	var mob = MOB.instance()
	add_child(mob)
