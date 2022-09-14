class_name GridNode

# GridNode

# Acts as a single node in a maze grid
# Keeps track of which directions it is connected in

# Enum representing the four directions that a node can be connected in
enum DIRECTIONS {
	UP,
	RIGHT,
	DOWN,
	LEFT
}

# Handles the directions in which the node can be connected
var connected_diretions := {
	DIRECTIONS.UP: false,
	DIRECTIONS.RIGHT: false,
	DIRECTIONS.DOWN: false,
	DIRECTIONS.LEFT: false
}

# Returns an integer containing bit flags representing each of the four directions
func get_connection_bits() -> int:
	var ret := 0
	if connected_diretions.get(DIRECTIONS.UP): ret += 1
	if connected_diretions.get(DIRECTIONS.RIGHT): ret += 2
	if connected_diretions.get(DIRECTIONS.DOWN): ret += 4
	if connected_diretions.get(DIRECTIONS.LEFT): ret += 8
	return ret

# Returns weither or not the node is connected in a certain direction
func get_connection(direction:int) -> bool:
	if not connected_diretions.has(direction):
		push_error("ERROR: direction %s not valid" % direction)
		return false
	return connected_diretions.get(direction)

# Returns a vector2 corresponding to the vector that each direction represents
func get_direction_vector(direction:int) -> Vector2:
	match direction:
		DIRECTIONS.UP:
			return Vector2.UP
		DIRECTIONS.RIGHT:
			return Vector2.RIGHT
		DIRECTIONS.DOWN:
			return Vector2.DOWN
		DIRECTIONS.LEFT:
			return Vector2.LEFT
	push_error("ERROR: direction %s not valid" % direction)
	return Vector2.ZERO

# Returns the direction coresponding to the vector input
func get_vector_direction(vector:Vector2) -> int:
	match vector:
		Vector2.UP:
			return DIRECTIONS.UP
		Vector2.RIGHT:
			return DIRECTIONS.RIGHT
		Vector2.DOWN:
			return DIRECTIONS.DOWN
		Vector2.LEFT:
			return DIRECTIONS.LEFT
	push_error("Vector %s not a valid direction" % String(vector))
	return 0

# Sets a direction to be either connected or unconnected
func set_connection(direction:int, value:bool):
	if not connected_diretions.has(direction):
		push_error("ERROR: direction %s not valid" % direction)
		return false
	connected_diretions[direction] = value

# Is this node connected on any sides?
func has_any_connections() -> bool:
	for i in connected_diretions.keys():
		if connected_diretions.get(i):
			return true
	return false
