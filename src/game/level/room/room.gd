extends Node2D
signal exit(direction)
export var door_left := false
export var door_right := false
export var door_up := false
export var door_down := false

onready var up: StaticBody2D = $doors/up
onready var right: StaticBody2D = $doors/right
onready var down: StaticBody2D = $doors/down
onready var left: StaticBody2D = $doors/left

onready var doors: Node2D = $doors


func completed():
	if door_up:
		up.open()
	if door_down:
		down.open()
	if door_left:
		left.open()
	if door_right:
		right.open()

func locked():
	if door_up:
		up.close()
	if door_down:
		down.close()
	if door_left:
		left.close()
	if door_right:
		right.close()
		
func _ready() -> void:
	setup_door(up,door_up,"up")
	setup_door(down,door_down,"down")
	setup_door(left,door_left,"left")
	setup_door(right,door_right,"right")

	

	completed()
	pass

func setup_door(door,enabled,direction):
	if !enabled:
		door.hide()
	else:
		door.connect("player_exiting_through",self,"exit", [direction])

func exit(direction):
	emit_signal("exit",direction)
