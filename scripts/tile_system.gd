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
	
	for i in range(8):
		data = fix_noise(data, true)
	data = fix_noise(data, true)
	map_data = data
	shift_map_data() ## make map data system readable
	
	## add ores
	add_ores()
	
	## grow ores ( with add_ores() ?)
	## structures?
	## obsidian borders
	## sync with other clients
	make_tile_children()

## go through each tile and choose random (more likely for stone)
func add_ores():
	for y in range(map_data.size()):
		for x in range(map_data[0].size()):
			if map_data[y][x] == tile_data.get_tile_by_name("Stone").get("tml_id"):
				## that's just a long way of saying "if the current tile is stone"
				for tile in tile_data.TILES:
					if tile.get("natural") and tile.get("ore"):
						if randi_range(0,tile.get("rarity")) == 0:
							grow_ore(x,y,tile.get("tml_id"),tile.get("grow_rate"))
							break

func grow_ore(x,y,id,rate):
	if !out_of_bounds(x,y) and rate > 0:
		map_data[y][x] = id
		if randf() < .25:
			grow_ore(x,y+1,id,rate-1)
		if randf() < .25:
			grow_ore(x,y-1,id,rate-1)
		if randf() < .25:
			grow_ore(x+1,y,id,rate-1)
		if randf() < .25:
			grow_ore(x-1,y,id,rate-1)

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
				get_item(noise,x-1,y-1), ## tl
				get_item(noise,x,y-1), ## tm
				get_item(noise,x+1,y-1), ## tr
				get_item(noise,x-1,y), ## ml
				get_item(noise,x+1,y), ## mr
				get_item(noise,x-1,y+1), ## bl
				get_item(noise,x,y+1), ## bm
				get_item(noise,x+1,y+1), ## br
			]
			
			var s = get_life_from_neighbors(inputs, noise[y][x])
			
			if overwrite:
				if !(x >= length[0]-3 or y >= length[1]-3 or x <= 2 or y <= 2):
					noise[y][x] = s
			else:
				current_line.append(s)
		if !overwrite:
			fixed.append(current_line)

	if overwrite:
		return noise
	else:
		return fixed

func get_life_from_neighbors(inputs: Array,current) -> int:
	var value := 0
	for i in inputs:
		value += i
	if value >= 6:
		return 1
	elif value >= 4:
		return current
	return 0

func get_item(noise: Array, x: int, y: int) -> int:
	if out_of_bounds(x,y):
		return 1
	
	return noise[y][x]

func out_of_bounds(x,y):
	var length = tile_data.map_size
	var x_length = length[0]
	var y_length = length[1]
	if x >= x_length or y >= y_length or x < 0 or y < 0:
		return true
	return false
