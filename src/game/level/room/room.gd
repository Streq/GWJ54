extends Node2D
signal exit(direction)
signal clear()
export var door_left := false
export var door_right := false
export var door_up := false
export var door_down := false

onready var up: StaticBody2D = $doors/up
onready var right: StaticBody2D = $doors/right
onready var down: StaticBody2D = $doors/down
onready var left: StaticBody2D = $doors/left

onready var doors: Node2D = $doors

var state : RoomState = RoomState.new()

func begin_clear():
	opened()
	state.cleared = true
	emit_signal("clear")


func clear():
	open()
	state.cleared = true
	emit_signal("clear")
	
	
func open():
	if door_up:
		up.open()
	if door_down:
		down.open()
	if door_left:
		left.open()
	if door_right:
		right.open()
func opened():
	if door_up:
		up.opened()
	if door_down:
		down.opened()
	if door_left:
		left.opened()
	if door_right:
		right.opened()
func close() -> void:
	print("close")
	if door_up:
		up.close()
	if door_down:
		down.close()
	if door_left:
		left.close()
	if door_right:
		right.close()
	state.cleared = false
		
func _ready() -> void:
	
	setup_door(up,door_up,"up")
	setup_door(down,door_down,"down")
	setup_door(left,door_left,"left")
	setup_door(right,door_right,"right")
	
	if state.cleared:
		begin_clear()
	else:
		close()
	

func setup_door(door,enabled,direction):
	if !enabled:
		door.hide()
	else:
		door.connect("player_exiting_through",self,"exit", [direction])

func exit(direction):
	emit_signal("exit",direction)

