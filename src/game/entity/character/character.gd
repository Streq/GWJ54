extends KinematicBody2D
class_name Character

signal dying()
signal dead()

export var damping := 0.0

export var team := 0

onready var input_state := $"%input_state"
onready var animation_player := $"%animation_player"
onready var state_machine := $"%state_machine"
onready var pivot: Node2D = $"%pivot"


var velocity := Vector2()

var vertical_position := 0.0
var vertical_velocity := 0.0
export var gravity := 100.0


export var speed := 200.0


var previous_velocity := Vector2()
var dead = false

func _ready() -> void:
	state_machine.initialize()



func _physics_process(delta: float) -> void:
	state_machine.physics_update(delta)
	animation_player.advance(delta)
	
	previous_velocity = velocity
	
	velocity = move_and_slide(velocity)
	
	velocity *= 1-delta*damping
	
	vertical_velocity += gravity * delta
	vertical_position = min(0.0, vertical_position+vertical_velocity*delta)
	pivot.position.y = vertical_position*4.0
	pivot.scale = Vector2(1,1) * (1 - vertical_position/ 10.0)
	if is_on_floor():
		vertical_velocity = min(0.0, vertical_velocity)
	
	if dead:
		die()

func is_on_floor():
	return vertical_position == 0.0

func die():
	if state_machine.current.is_dead_state:
		return
	dead = true
	state_machine._change_state("dead")
	emit_signal("dying")
	emit_signal("dead")

