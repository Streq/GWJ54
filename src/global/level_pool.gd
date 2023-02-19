extends Node

export (Array, Array, PackedScene) var pools : Array
export (Array, PackedScene) var boss_pool : Array

export var very_start_room : PackedScene
export var start_room : PackedScene
export var boss_room : PackedScene
export var final_boss_room : PackedScene
export var reward_room : PackedScene

onready var special_rooms = {"s":start_room,"S":very_start_room,"f":boss_room,"F":final_boss_room,"R":reward_room}

func get_random_id(level:int):
	level = clamp(level, 0, pools.size()-1)
	return randi()%pools[level].size()

func get_room(level,id):
	if typeof(id) == TYPE_STRING:
		var strid : String = id
		return special_rooms[strid.substr(0,1)]
	return pools[level][id]
