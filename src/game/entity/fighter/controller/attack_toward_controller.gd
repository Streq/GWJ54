extends Node2D

onready var timer: Timer = $Timer
onready var delay_timer: Timer = $delay_timer

var last_hit_right = true
var should_hit = false
	
export var delay_base := 0.2
export var delay_random := 0.5

func _ready() -> void:
	delay_timer.connect("timeout",self,"punch")
#	queue_free()
func _physics_process(delta: float) -> void:
	var target = Group.get_one("player")
	if !is_instance_valid(target):
		return
	
	if timer.is_stopped() and delay_timer.is_stopped() and global_position.distance_squared_to(target.global_position)<100*100:
		
		timer.start()
		var wait_time = delay_base+delay_random*randf()
		if wait_time < 0.0166667:
			punch()
		else:
			delay_timer.wait_time = wait_time
			delay_timer.start()
	
	get_parent().input_state.A.set_pressed(should_hit and last_hit_right)
	get_parent().input_state.B.set_pressed(should_hit and !last_hit_right)
	
	get_parent().input_state.dir = global_position.direction_to(target.global_position)
	get_parent().input_state.aim_pos = target.global_position
	should_hit = false

func punch():
	should_hit = true
	last_hit_right = !last_hit_right
