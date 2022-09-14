class_name MazeDrawer
extends Node2D

export (float) var grid_size = 32.0

var maze setget set_maze

func set_maze(new_maze):
	maze = new_maze
	update()

func _draw():
	if not maze:
		return
	for x in maze.grid_columns:
		for y in maze.grid_rows:
			var node = maze.get_node(x,y)
			var center_pos = Vector2(x,y) * grid_size
			var diag_ru = (center_pos + Vector2(grid_size * 0.5, -grid_size * 0.5))
			var diag_lu = (center_pos + Vector2(-grid_size * 0.5, -grid_size * 0.5))
			var diag_rd = (center_pos + Vector2(grid_size * 0.5, grid_size * 0.5))
			var diag_ld = (center_pos + Vector2(-grid_size * 0.5, grid_size * 0.5))
			if not node.connected_diretions.get(node.DIRECTIONS.UP):
				draw_line(diag_ru, diag_lu, Color.yellow, 5)
			if not node.connected_diretions.get(node.DIRECTIONS.DOWN):
				draw_line(diag_rd, diag_ld, Color.yellow, 5)
			if not node.connected_diretions.get(node.DIRECTIONS.LEFT):
				draw_line(diag_lu, diag_ld, Color.yellow, 5)
			if not node.connected_diretions.get(node.DIRECTIONS.RIGHT):
				draw_line(diag_ru, diag_rd, Color.yellow, 5)
