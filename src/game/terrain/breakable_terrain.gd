extends TileMap


signal tile_hit(global_position)
signal tile_destroyed(global_position)

export var count_as_crash := true


const DESTRUCTIBLE_TILES = {
	11:12,
	12:13,
	13:14,
	14:-1
}

const STRONG_DESTRUCTIBLE_TILES = {
	16:11
}

func hit_destructible_terrain(point: Vector2, damage := 1, can_damage_strong := false):
	var local = to_local(point)
	var map_coord = world_to_map(point)
	
	var tile_id = get_cellv(map_coord)
	
	
		
#	print(tile_id)
	if !tile_id in DESTRUCTIBLE_TILES and (!can_damage_strong or !tile_id in STRONG_DESTRUCTIBLE_TILES):
#		SFX.play("bullet_wall", point)
		return
	var new_id = tile_id
	if can_damage_strong and tile_id in STRONG_DESTRUCTIBLE_TILES:
		new_id = STRONG_DESTRUCTIBLE_TILES[tile_id]
		damage -= 1
	
	for i in damage:
		new_id = DESTRUCTIBLE_TILES[new_id]
		if !new_id in DESTRUCTIBLE_TILES:
			break
	set_cellv(map_coord,new_id)
	if new_id != -1:
		emit_signal("tile_hit", point)
	else:
		emit_signal("tile_destroyed", point)

func terrain_get_hit(bullet, collision:KinematicCollision2D):
	hit_destructible_terrain(collision.position-collision.normal)
	pass

