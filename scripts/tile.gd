extends TileMapLayer

var data: Dictionary
var map_data: Array



func create():
	for y in range(map_data.size() + 1):
		for x in range(map_data[0].size() + 1):
			set_cell(Vector2i(x,y),data.get("tml_id"),get_best_fit_tile(x,y))

func clamp_and_get_val(x,y) -> int:
	if x < 0 or y < 0 or x >= map_data[0].size() or y >= map_data.size():
		return 0
	return int(map_data[y][x] == data.get("tml_id"))

func get_best_fit_tile(x,y) -> Vector2i:
	var return_value := Vector2i(0,0)
	var corners =[
		clamp_and_get_val(x-1,y-1),
		clamp_and_get_val(x,y-1),
		clamp_and_get_val(x-1,y),
		clamp_and_get_val(x,y),
	]
	
	match corners:
		[
			0,0,
			0,0,
		]:
			return_value = Vector2i(-1,-1)
		[
			0,0,
			0,1,
		]:
			return_value = Vector2i(3,0)
		[
			0,0,
			1,0,
		]:
			return_value = Vector2i(4,0)
		[
			0,0,
			1,1,
		]:
			return_value = Vector2i(1,2)
		[
			0,1,
			0,0,
		]:
			return_value = Vector2i(3,1)
		[
			0,1,
			0,1,
		]:
			return_value = Vector2i(2,1)
		[
			0,1,
			1,0,
		]:
			return_value = Vector2i(4,2)
		[
			0,1,
			1,1,
		]:
			return_value = Vector2i(2,2)
		[
			1,0,
			0,0,
		]:
			return_value = Vector2i(4,1)
		[
			1,0,
			0,1,
		]:
			return_value = Vector2i(3,2)
		[
			1,0,
			1,0,
		]:
			return_value = Vector2i(0,1)
		[
			1,0,
			1,1,
		]:
			return_value = Vector2i(0,2)
		[
			1,1,
			0,0,
		]:
			return_value = Vector2i(1,0)
		[
			1,1,
			0,1,
		]:
			return_value = Vector2i(2,0)
		[
			1,1,
			1,0,
		]:
			return_value = Vector2i(0,0)
		[
			1,1,
			1,1,
		]:
			return_value = Vector2i(1,1)
	
	return return_value


func _on_ready() -> void:
	create()
