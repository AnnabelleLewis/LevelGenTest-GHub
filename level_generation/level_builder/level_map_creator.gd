class_name LevelMapCreator
extends Node

# Level Map Creator
# Acts as an in-scene host for a LevelMapBuilder object

export (Array, Resource) var chunks
var map_builder : LevelMapBuilder


func _ready():
	map_builder = LevelMapBuilder.new(chunks)

func get_level_map(maze:NodeGrid):
	return map_builder.build_maze(maze)

# Function courtesy of https://gist.github.com/hiulit/772b8784436898fd7f942750ad99e33e
func get_all_files(path: String, file_ext := "", files := []):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true, true)
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				files = get_all_files(dir.get_current_dir().plus_file(file_name), file_ext, files)
			else:
				if file_ext and file_name.get_extension() != file_ext:
					file_name = dir.get_next()
					continue
				files.append(load(file_name))
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access %s." % path)
	return files
