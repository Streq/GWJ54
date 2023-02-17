extends Node2D
export var ROOM : PackedScene

var opposite = {
	"up":"down",
	"down":"up",
	"left":"right",
	"right":"left"
}

onready var current_room = $room
onready var dude: KinematicBody2D = $dude2



func _on_room_exit(direction):
	var new_room = ROOM.instance()
	var entrance = opposite[direction]
	new_room.set("door_"+entrance,true)
	current_room.queue_free()
	add_child(new_room)
	current_room = new_room
	current_room.connect("exit",self,"_on_room_exit")
	dude.position = current_room.get(entrance).player_spawn.global_position
