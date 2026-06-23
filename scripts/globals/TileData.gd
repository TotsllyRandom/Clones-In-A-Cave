extends Node

# Map Variables:
var map_size: Array = [200, 120] ## x size, y size
var obsidian_border := 5

# Tiles

## layout -
"""
Layout:
	{
		"name": "",
		"tml_id": 0,
		"strength": 0, ## time it takes to mine
		"sell_price": 0, ## money made from mining
		"natural": true, ## true if it will naturally generate
		"rarity": 0, ## spawn rarity, ignore if not natural
		"ore": false, ## true if it generates as an ore, not like stone
		
		## ore settings, ignore if not ore
		"grow_rate": 0, ## max times the vein will grow. 50/50 chance to grow once for each number
	},
"""
const TILES = [
	{
		"name": "Obsidian",
		"tml_id": 4,
		"strength": 20, ## time it takes to mine
		"sell_price": 50, ## money made from mining
		"natural": true, ## true if it will naturally generate
		"rarity": 0, ## spawn rarity, ignore if not natural
		"ore": false, ## true if it generates as an ore, not like stone
		
		## ore settings, ignore if not ore
		"grow_rate": 0, ## max times the vein will grow. 50/50 chance to grow once for each number
	},
	
	{
		"name": "Stone",
		"tml_id": 0,
		"strength": 2, ## time it takes to mine
		"sell_price": 1, ## money made from mining
		"natural": true, ## true if it will naturally generate
		"rarity": 1, ## spawn rarity, ignore if not natural
		"ore": false, ## true if it generates as an ore, not like stone
		
		## ore settings, ignore if not ore
		"grow_rate": 0, ## max times the vein will grow. 50/50 chance to grow once for each number
	},
	{
		"name": "Iron",
		"tml_id": 1,
		"strength": 5, ## time it takes to mine
		"sell_price": 10, ## money made from mining
		"natural": true, ## true if it will naturally generate
		"rarity": 20, ## spawn rarity, ignore if not natural
		"ore": true, ## true if it generates as an ore, not like stone
		
		## ore settings, ignore if not ore
		"grow_rate": 3, ## max times the vein will grow. 50/50 chance to grow once for each number
	},
	{
		"name": "Gold",
		"tml_id": 2,
		"strength": 20, ## time it takes to mine
		"sell_price": 50, ## money made from mining
		"natural": true, ## true if it will naturally generate
		"rarity": 80, ## spawn rarity, ignore if not natural
		"ore": true, ## true if it generates as an ore, not like stone
		
		## ore settings, ignore if not ore
		"grow_rate": 1, ## max times the vein will grow. 50/50 chance to grow once for each number
	},
	
	{
		"name": "Coal",
		"tml_id": 3,
		"strength": 5, ## time it takes to mine
		"sell_price": 5, ## money made from mining
		"natural": true, ## true if it will naturally generate
		"rarity": 18, ## spawn rarity, ignore if not natural
		"ore": true, ## true if it generates as an ore, not like stone
		
		## ore settings, ignore if not ore
		"grow_rate": 4, ## max times the vein will grow. 50/50 chance to grow once for each number
	},
]

func sort_tiles(key: String) -> Array:
	var ret = []
	var timsort_types= [
		TYPE_INT,
	]
	if timsort_types.has(typeof(TILES[0].get(key))):
		var splits = []
		var current_split = []
		var current_val = TILES[0].get(key)
		current_split.append(TILES[0])
			
		for i in range(1, TILES.size()):
			var tile = TILES[i]
			
			if tile.get(key) < current_val:
				splits.append(current_split)
				current_split = []
			
			current_split.append(tile)
			current_val = tile.get(key)
		splits.append(current_split)
		
		while splits.size() > 1:
			var new_splits = []
			for i in range(0, splits.size(), 2):
				var left = splits[i]
				
				if i + 1 >= splits.size():
					new_splits.append(left)
					continue
				
				var right = splits[i + 1]
				
				for item in right:
					var inserted = false
					for j in range(left.size()):
						if left[j].get(key) >= item.get(key):
							left.insert(j, item)
							inserted = true
							break
					if !inserted:
						left.append(item)
				
				new_splits.append(left)
			splits = new_splits
		ret = splits[0]
	
	return ret

func get_tile_by_name(n:String):
	for tile in TILES:
		if tile.get("name") == n:
			return tile

#func get_array_of_rarities() -> Array:
	#pass
