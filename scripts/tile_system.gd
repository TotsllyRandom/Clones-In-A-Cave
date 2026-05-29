extends Node2D

## Create Map, Create Tile instances, Handle changes to map

@export var TILESCENE: PackedScene
var map_data: Array
var obsidian_border

signal map_changed(x,y)

# on start: 
# make map data (noise -> caves) ->
# make new tile scene with current tile ID for each global tile ->

# on change:
# update nearby tiles (if x,y is changed, update from range x-1 -> x+1, y-1 -> y+1)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_main_game_start() -> void:
	## generate noise
	## fix noise
	var data = generate_noise()
	
	for i in range(3):
		data = fix_noise(data, false)
	data = fix_noise(data, true)
	map_data = data
	shift_map_data() ## make map data system readable
	
	## add ores
	## grow ores
	## structures?
	## obsidian borders
	## sync with other clients
	make_tile_children()
	
func shift_map_data():
	for y in range(map_data.size()):
		for x in range(map_data[0].size()):
			if x <= 2 or y <= 2 or x >= map_data[0].size() - 3 or y >= map_data.size() -3:
				map_data[y][x] = 0
				continue
			
			if map_data[y][x] == 0:
				map_data[y][x] = -1
			else:
				map_data[y][x] = 0

func make_tile_children():
	for tile in tile_data.TILES:
		var t = TILESCENE.instantiate()
		t.position.x = -16
		t.position.y = -16
		t.name = tile.get("name")
		t.data = tile
		t.map_data = map_data
		t.create()
		add_child(t)

func generate_noise() -> Array:
	var noise = []
	var current_line = []
	for y in tile_data.map_size[1]:
		current_line = [] 
		for x in tile_data.map_size[0]:
			current_line.append(int(randf() < .65))
		noise.append(current_line)
	return noise

func fix_noise(noise: Array, overwrite: bool) -> Array:
	var fixed = []
	var current_line = []
	var length = tile_data.map_size
	for y in range(noise.size()):
		current_line = []
		for x in range(noise[0].size()):
			var inputs = [
				0, ## tl
				0, ## tm
				0, ## tr
				0, ## ml
				0, ## mr
				0, ## bl
				0, ## bm
				0, ## br
			]
			inputs[0] = get_item(noise,x-1,y-1,length[0],length[1])
			inputs[1] = get_item(noise,x,y-1,length[0],length[1])
			inputs[2] = get_item(noise,x+1,y-1,length[0],length[1])
			inputs[3] = get_item(noise,x-1,y,length[0],length[1])
			inputs[4] = get_item(noise,x+1,y,length[0],length[1])
			inputs[5] = get_item(noise,x-1,y+1,length[0],length[1])
			inputs[6] = get_item(noise,x,y+1,length[0],length[1])
			inputs[7] = get_item(noise,x+1,y+1,length[0],length[1])
			
			var s = int(get_life_from_neighbors(inputs))
			if overwrite:
				if !(x >= length[0]-3 or y >= length[1]-3 or x <= 2 or y <= 2):
					noise[y][x] = s
				#else:
					#noise[y][x] = 1
			else:
				current_line.append(s)
		if !overwrite:
			fixed.append(current_line)
	if overwrite:
		return noise
	else:
		return fixed

func get_life_from_neighbors(inputs: Array) -> bool:
	var value := 0
	for i in inputs:
		value += i
	return value > 4

func get_item(noise: Array, x: int, y: int, x_length: int, y_length: int) -> int:
	if x >= x_length or y >= y_length or x < 0 or y < 0:
		return 1
	
	return noise[y][x]
