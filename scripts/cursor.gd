extends TileMapLayer

var mouse_pos: Vector2i

signal clicked(x,y)

func get_mouse_position():
	mouse_pos = local_to_map(get_global_mouse_position())

func _process(_delta: float):
	get_mouse_position()
	clear()
	set_cell(mouse_pos,0,Vector2i(0,3))
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		clicked.emit(mouse_pos.x,mouse_pos.y)
