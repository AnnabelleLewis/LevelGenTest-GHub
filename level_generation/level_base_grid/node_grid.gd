class_name NodeGrid

# Node grid

# Holds a grid of node objects
#  Handles the connecction and deconnection of these nodes

# 2D array of grid nodes
var grid := []

var grid_columns := 0 # X dimention of the grid
var grid_rows := 0 # Y dimention of the grid

func _init(columns:int, rows:int):
	for i in rows:
		grid.append([])
		for j in columns:
			grid[i].append(GridNode.new())
	grid_columns = columns
	grid_rows = rows

# Returns the grid node at a specifix x,y coordinate
func get_node(column:int, row:int) -> GridNode:
	if not is_valid_node_poz(column,row):
		return GridNode.new()
		push_error("ERROR:Row %s out of bounds"%row)
	return grid[row][column]

# Returns weither or not two nodes have been connected
func are_nodes_connected(column1:int, row1:int, column2:int, row2:int) -> bool:
	if not is_valid_node_poz(column1,row1):
		return false
		push_error("ERROR:Column1 %s out of bounds"%column1)
	if not is_valid_node_poz(column2,row2):
		return false
		push_error("ERROR:Column2 %s out of bounds"%column2)
	if not are_nodes_touching(column1, row1, column2, row2):
		push_error("ERROR:Nodes not touching")
	var node1 := get_node(column1, row1)
	var node2 := get_node(column2, row2)
	var direction_from_1 = node1.get_vector_direction(Vector2(column1, row1) - Vector2(column2, row2))
	var direction_from_2 = node2.get_vector_direction(Vector2(column2, row2) - Vector2(column1, row1))
	return node1.get_connection(direction_from_1) and node2.get_connection(direction_from_2)

# Returns weither or not two nodes share an edge
func are_nodes_touching(column1:int, row1:int, column2:int, row2:int) -> bool:
	return Vector2(column1, row1).distance_to(Vector2(column2, row2)) < 1.1

# Sets two nodes to be either connected or disconnected
func set_node_connection(column1:int, row1:int, column2:int, row2:int, connection: bool):
	if not is_valid_node_poz(column1,row1):
		return false
		push_error("ERROR:Column1 %s out of bounds"%column1)
	if not is_valid_node_poz(column2,row2):
		return false
		push_error("ERROR:Column2 %s out of bounds"%column2)
	if not are_nodes_touching(column1, row1, column2, row2):
		push_error("ERROR:Nodes not touching")
	var node1 := get_node(column1, row1)
	var node2 := get_node(column2, row2)
	var direction_from_2 = node2.get_vector_direction(Vector2(column1, row1) - Vector2(column2, row2))
	var direction_from_1 = node1.get_vector_direction(Vector2(column2, row2) - Vector2(column1, row1))
	node1.set_connection(direction_from_1,connection)
	node2.set_connection(direction_from_2,connection)

func is_valid_node_poz(column, row) -> bool:
	if column >= grid_columns or column < 0:
		return false
	if row >= grid_rows or row < 0:
		return false
	return true
