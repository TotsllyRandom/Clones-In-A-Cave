extends Node

# Map Variables:
var map_size: Array = [200, 120] ## x size, y size

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
		"tml_id": 3,
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
		"grow_rate": 4, ## max times the vein will grow. 50/50 chance to grow once for each number
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
		"grow_rate": 2, ## max times the vein will grow. 50/50 chance to grow once for each number
	},
]

func get_tile_by_name(n:String):
	for tile in TILES:
		if tile.get("name") == n:
			return tile

#func get_array_of_rarities() -> Array:
	#pass
