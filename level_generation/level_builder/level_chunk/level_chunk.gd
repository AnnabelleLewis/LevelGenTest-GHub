class_name LevelChunk
extends Resource


export (StreamTexture) var tilemap
export (bool) var connected_up
export (bool) var connected_right
export (bool) var connected_down
export (bool) var connected_left
export (Array, Resource) var spawn_points

# Returns an integer containing bit flags representing each of the four directions
func get_connection_bits() -> int:
	var ret := 0
	if connected_up: ret += 1
	if connected_right: ret += 2
	if connected_down: ret += 4
	if connected_left: ret += 8
	return ret

# Get tilemap represented by the chunk
func get_tilemap() -> Array:
	var ret_array := []
	var image : Image = tilemap.get_data()
	image.lock()
	for y in image.get_height():
		ret_array.append([])
		for x in image.get_width():
			match image.get_pixel(x,y):
				Color.black:
					ret_array[y].append(1)
				Color.white:
					ret_array[y].append(0)
	return ret_array
