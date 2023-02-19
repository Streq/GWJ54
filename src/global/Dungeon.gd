extends Node
class_name Dungeon

var map = []
var ROOMS = 100
var occupied_rooms = []

export var level := 0


func _ready() -> void:
	
	
	generate_dungeon()
	
func generate_dungeon() -> void:
	generate_dungeon_attempt()
	while occupied_rooms.size()<ROOMS:
		generate_dungeon_attempt()

func generate_dungeon_attempt() -> void:
	map = []
	map.resize(10*10)
	ROOMS = int((randi()%3) + 5 + 2.6*(level+1))
	map[44] = "s" if level != 0 else "S"
	var room_queue = [44]
	occupied_rooms = [44]
	var end_rooms = []
	while !room_queue.empty():
		var current_room = room_queue.pop_front()
	#	Determine the neighbour cell by adding +10/-10/+1/-1 to the current cell.
		var added_neighbours = 0
		for offset in [10,-10,1,-1]:
			var neighbour = current_room + offset
			# If the neighbour cell is outside boundaries, give up
			if (
				neighbour < 0 or 
				neighbour >= 100 or 
				((neighbour/10!=current_room/10) and (neighbour%10 != current_room%10))
			):
				continue
			#	If the neighbour cell is already occupied, give up
			if map[neighbour] != null:
				continue
			#	If the neighbour cell itself has more than one filled neighbour, give up.
			var neighbours_filled_neighbours = 0
			for offset2 in [10,-10,1,-1]:
				var neighbours_neighbour = neighbour + offset2
				if (
					neighbours_neighbour < 0 or 
					neighbours_neighbour >= 100 or 
					((neighbours_neighbour/10!=neighbour/10) and (neighbours_neighbour%10 != neighbour%10))
				):
					continue
				if map[neighbours_neighbour] != null:
					neighbours_filled_neighbours += 1
			if neighbours_filled_neighbours > 1:
				continue
			#	If we already have enough rooms, give up
			if occupied_rooms.size() >= ROOMS:
				continue
			#	Random 50% chance, give up
			if randf()<0.5:
				continue
			#	Otherwise, mark the neighbour cell as having a room in it, and add it to the queue.
			map[neighbour] = RoomPool.get_random_id(level)
			occupied_rooms.append(neighbour)
			room_queue.push_back(neighbour)
			added_neighbours += 1
		if added_neighbours == 0:
			end_rooms.append(current_room)
	
	if end_rooms:
		map[end_rooms.pop_back()] = "f"+str(randi()%ItemPool.pool.size())
	if end_rooms:
		map[end_rooms.pop_back()] = "R"+str(randi()%ItemPool.pool.size())
	print_map()

func print_map():
	var map_representation = ""
	for i in map.size():
		if !(i % 10):
			 map_representation+="\n"
		if map[i]==null:
			map_representation += "_"
		else:
			map_representation += str(map[i])
	print(map_representation)

func get_cell(pos:Vector2):
	return map[pos_to_id(pos)]

func pos_to_id(pos:Vector2)->int:
	return int(pos.x+10*pos.y)

func id_to_pos(id:int)->Vector2:
	return Vector2(id%10,id/10)

func set_cell(pos:Vector2, value):
	map[pos_to_id(pos)] = value
