class_name LevelBuilder
extends TileMap

export (int) var chunk_size := 16
export (int) var tile_size := 32

func build_level(chunk_grid:Array):
	for chunk_y in chunk_grid.size():
		for chunk_x in chunk_grid[chunk_y].size():
			var chunk_origin_x = chunk_x * chunk_size# * tile_size
			var chunk_origin_y = chunk_y * chunk_size# * tile_size
			var chunk :LevelChunk = chunk_grid[chunk_y][chunk_x]
			var tilemap = chunk.get_tilemap()
			for x in chunk_size:
				for y in chunk_size:
					set_cell(
						(x) + chunk_origin_x,
						(y) + chunk_origin_y,
						tilemap[y][x])
