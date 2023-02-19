extends Weapon
signal jump

var casting = false
onready var cooldown: Timer = $cooldown


func _cast():
	if !cooldown.is_stopped() or !wielder.is_on_floor() or casting:
		cast_over()
		return
	emit_signal("jump")
	cooldown.start()
	casting = true
	wielder.vertical_velocity = -5.0
	var dir = wielder.input_state.dir
	if !dir:
		dir = wielder.input_state.get_aim_dir()
	wielder.velocity = 400.0*dir
	casting = false
	
	cast_over()
	
	
func _physics_process(delta: float) -> void:
	if !casting:
		return
		
