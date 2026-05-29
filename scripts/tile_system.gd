extends Node2D

@export var TILESCENE: PackedScene
var map_data: Array

# on start: 
# make map data (noise -> caves) ->
# make new tile scene with current tile ID for each global tile ->

# on change:
# update nearby tiles (if x,y is changed, update from range x-1 -> x+1, y-1 -> y+1)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_game_start() -> void:
	## generate noise
	## fix noise
	fix_noise(generate_noise())
	
	## add ores
	## grow ores
	## structures?

func generate_noise():
	pass

func fix_noise(noise: Array):
	pass
