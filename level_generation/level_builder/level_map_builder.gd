class_name LevelMapBuilder

# LevelMapBuilder: Takes in a NodeGrid, and transforms it into a 2D Array of chunk objects

# Contains a dict of arrays mapped to the integer expressions of their connectedness
var chunks := {}

func _init(chunk_array:Array):
	for i in chunk_array:
		if not i is LevelChunk: continue
		if not chunks.has(i.get_connection_bits()): 
			chunks[i.get_connection_bits()] = [i]
		else:
			chunks[i.get_connection_bits()].append(i)

func build_maze(maze:NodeGrid) -> Array:
	var ret_array = []
	for y in maze.grid_rows:
		ret_array.append([])
		for x in maze.grid_columns:
			var con_int = maze.get_node(x,y).get_connection_bits()
			if not chunks.has(con_int):
				push_error("Chunk for %s not found"%con_int)
				continue
			var chunk_array : Array = chunks[con_int]
			ret_array[y].append(chunk_array[randi() % chunk_array.size()])
	return ret_array
