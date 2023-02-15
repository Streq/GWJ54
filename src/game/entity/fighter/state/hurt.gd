extends CharacterState

export var damping := 0.0


var timer := Timer.new()

func _init() -> void:
	timer.process_mode = Timer.TIMER_PROCESS_PHYSICS 
	timer.one_shot = true
	timer.wait_time = 0.5

func _ready() -> void:
	add_child(timer)
	
func _enter(params):
	timer.start()
	pass


func _physics_update(delta: float):
	if timer.is_stopped():
		goto("casting")
	pass
