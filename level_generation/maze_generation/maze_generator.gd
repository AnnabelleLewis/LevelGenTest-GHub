class_name MazeGenerator

# Class for generating mazes

# Generates a maze using an iteritive, depth-first algorithim

static func generate_maze(width, height, starting_x, starting_y, up_weight = 1, right_weight = 1, down_weight = 1, left_weight = 1, loopback_chance = 0.0) -> NodeGrid:
	var maze := NodeGrid.new(width, height) # Maze grid to return
	var return_stack := [Vector2(starting_x, starting_y)] # Stack of x,y positions of that should be returned to for visiting
	var visited_nodes := [return_stack[0]]
	while return_stack.size() > 0:
		var current_node_pos : Vector2 = return_stack.pop_front()
		
		var up_pos = current_node_pos + Vector2.UP
		var right_pos = current_node_pos + Vector2.RIGHT
		var down_pos = current_node_pos + Vector2.DOWN
		var left_pos = current_node_pos + Vector2.LEFT
			
		var valid_neighbors = []
		
		try_add_dir_to_array(up_pos,valid_neighbors,visited_nodes,maze,up_weight,loopback_chance)
		try_add_dir_to_array(right_pos,valid_neighbors,visited_nodes,maze,right_weight,loopback_chance)
		try_add_dir_to_array(down_pos,valid_neighbors,visited_nodes,maze,down_weight,loopback_chance)
		try_add_dir_to_array(left_pos,valid_neighbors,visited_nodes,maze,left_weight,loopback_chance)
		
		if valid_neighbors.size() > 0:
			var next_pos = valid_neighbors[randi() % valid_neighbors.size()]
			visited_nodes.append(next_pos)
			maze.set_node_connection(current_node_pos.x,current_node_pos.y,next_pos.x,next_pos.y,true)
			return_stack.push_front(current_node_pos)
			return_stack.push_front(next_pos)
	return maze

static func try_add_dir_to_array(dir,add_array,visited_nodes,map,weight, loop_chance):
	if visited_nodes.has(dir) and rand_range(0.0,1.0) > loop_chance: 
		return
	if not map.is_valid_node_poz(dir.x, dir.y): 
		return
	for i in weight:
		add_array.append(dir)
	
