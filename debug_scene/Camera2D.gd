extends Camera2D


const speed := 64

func _process(delta):
	position += Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * speed
