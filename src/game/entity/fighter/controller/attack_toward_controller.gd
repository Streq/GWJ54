extends Node2D

onready var timer: Timer = $Timer
onready var delay_timer: Timer = $delay_timer

var last_hit_right = true
var should_hit = false
	

export var delay_on_spawn := 1.0

export var delay_base := 0.2
export var delay_random := 0.5

export var time_between_attacks := 1.0

export var attack_range := 100.0
onready var spawn_delay: Timer = $spawn_delay

enum Hands{
	BOTH = 0,
	LEFT = 1,
	RIGHT = 2
}

export (Hands) var hands := Hands.BOTH

func _ready() -> void:
	delay_timer.connect("timeout",self,"punch")
	spawn_delay.wait_time = delay_on_spawn
	spawn_delay.start()
	timer.wait_time = time_between_attacks
	
#	queue_free()
func _physics_process(delta: float) -> void:
	var target = Group.get_one("player")
	if !is_instance_valid(target):
		return
	
	get_parent().input_state.aim_pos = target.global_position
	if !spawn_delay.is_stopped():
		return
	
	
	if timer.is_stopped() and delay_timer.is_stopped() and global_position.distance_squared_to(target.global_position)<attack_range*attack_range:
		
		timer.start()
		var wait_time = delay_base+delay_random*randf()
		if wait_time < 0.0166667:
			punch()
		else:
			delay_timer.wait_time = wait_time
			delay_timer.start()
	
	var input_state = get_parent().input_state
	
	if should_hit:
		pass
	
	match hands:
		Hands.BOTH:
			input_state.A.set_pressed(should_hit and last_hit_right)
			input_state.B.set_pressed(should_hit and !last_hit_right)
		Hands.LEFT:
			input_state.A.set_pressed(should_hit)
			input_state.B.set_pressed(false)
		Hands.RIGHT:
			input_state.A.set_pressed(false)
			input_state.B.set_pressed(should_hit)
			
		
	
	
	get_parent().input_state.dir = global_position.direction_to(target.global_position)
	should_hit = false

func punch():
	should_hit = true
	last_hit_right = !last_hit_right
