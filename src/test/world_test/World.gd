extends Node2D
export var ROOM : PackedScene

var dungeon = Dungeon.new()


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
onready var dude: KinematicBody2D = $dude2

func _ready() -> void:
	dungeon.generate_dungeon()
	setup_current_room()
	current_room.position = dude.position
func _on_room_exit(direction):
	current_room.queue_free()
	last_entrance = opposite[direction]
	
	current_room_position += direction_to_vector[direction]
#	dude.global_position = Vector2()
	call_deferred("setup_current_room")
#	current_room.position = dude.position  current_room.get(entrance).player_spawn.global_position
	
func offset_cell(from:int, offset:Vector2):
	pass

func setup_current_room():
	var new_room = ROOM.instance()
	new_room.door_up = dungeon.get_cell(current_room_position+Vector2.UP) != null
	new_room.door_down = dungeon.get_cell(current_room_position+Vector2.DOWN) != null
	new_room.door_left = dungeon.get_cell(current_room_position+Vector2.LEFT) != null
	new_room.door_right = dungeon.get_cell(current_room_position+Vector2.RIGHT) != null
	current_room = new_room
	add_child(current_room)
	current_room.connect("exit",self,"_on_room_exit")
	if last_entrance:
		current_room.position = dude.position - current_room.to_local(current_room.get(last_entrance).player_spawn.global_position)
	
