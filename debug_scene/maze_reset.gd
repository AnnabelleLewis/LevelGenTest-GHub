extends Button

export (NodePath) onready var drawer = get_node(drawer)
export (NodePath) onready var map_builder = get_node(map_builder)
export (NodePath) onready var level_creator = get_node(level_creator)

func _on_MazeResetController_pressed():
	var maze := MazeGenerator.generate_maze(
		$X.text.to_int(),
		$Y.text.to_int(),
		2,
		0,
		3,
		5,
		6,
		5,
		0.01
	)
	drawer.set_maze(maze)
	var map = map_builder.get_level_map(maze)
	level_creator.build_level(map)
