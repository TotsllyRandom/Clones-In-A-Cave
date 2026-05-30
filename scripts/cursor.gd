extends TileMapLayer

var mouse_pos: Vector2i

func get_mouse_position() -> Vector2i:
	return local_to_map(get_global_mouse_position())

func _process(_delta: float):
	clear()
	set_cell(get_mouse_position(),0,Vector2i(0,3))
