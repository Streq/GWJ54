extends Node2D

var dungeon = Dungeon.new()

var room_states = {}

var opposite = {
	"up":"down",
	"down":"up",
	"left":"right",
	"right":"left"
}

var direction_to_vector = {
	"up":Vector2.UP,
	"down":Vector2.DOWN,
	"left":Vector2.LEFT,
	"right":Vector2.RIGHT
}

var current_room_position = Vector2(4,4)

var last_entrance
onready var current_room
onready var dude: KinematicBody2D = $dude

func _ready() -> void:
	
	randomize()
	dungeon.generate_dungeon()
	setup_current_room()
	current_room.position = dude.position
	loss.set_process_input(false)
func _on_room_exit(direction):
	
	current_room.queue_free()
	var state = current_room.state
	room_states[current_room_position] = state
	
	last_entrance = opposite[direction]
	
	current_room_position += direction_to_vector[direction]
	
	
	
#	dude.global_position = Vector2()
	call_deferred("setup_current_room")
#	current_room.position = dude.position  current_room.get(entrance).player_spawn.global_position
	
func offset_cell(from:int, offset:Vector2):
	pass

func setup_current_room():
	var new_room = RoomPool.get_room(dungeon.level, current_room_cell()).instance()
	new_room.door_up = dungeon.get_cell(current_room_position+Vector2.UP) != null
	new_room.door_down = dungeon.get_cell(current_room_position+Vector2.DOWN) != null
	new_room.door_left = dungeon.get_cell(current_room_position+Vector2.LEFT) != null
	new_room.door_right = dungeon.get_cell(current_room_position+Vector2.RIGHT) != null
	current_room = new_room
	var state
	if room_states.has(current_room_position):
		state = room_states[current_room_position]
	if state:
		current_room.state = state
	
	add_child(current_room)
	
	
	current_room.connect("exit",self,"_on_room_exit")
	current_room.connect("next_level",self,"_on_next_level")
	if last_entrance:
		current_room.position = dude.position - current_room.to_local(current_room.get(last_entrance).player_spawn.global_position)

onready var loss: CanvasLayer = $loss


func _on_dude_dead() -> void:
#	yield(get_tree().create_timer(1.0),"timeout")
	loss.show()
	loss.set_process_input(true)

func _on_next_level():
	current_room.queue_free()
	room_states = {}
	dungeon.level += 1
	dungeon.generate_dungeon()
	current_room_position = Vector2(4,4)
	setup_current_room()
	current_room.position = dude.position

func current_room_cell():
	return dungeon.get_cell(current_room_position)
