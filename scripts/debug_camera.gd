extends Camera2D

const speed = 50
var limits = [
	0,
	0,
	0,
	0,
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	limits[2] = (tile_data.map_size[0] + tile_data.obsidian_border * 2) * 32 - (get_viewport_rect().size.x / 2)
	limits[3] = (tile_data.map_size[1] + tile_data.obsidian_border * 2) * 32 - (get_viewport_rect().size.y / 2)
	position.x = limits[2]/2
	position.y = limits[3]/2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("debug_camRight"):
		position.x += speed
	if Input.is_action_pressed("debug_camLeft"):
		position.x -= speed
	if Input.is_action_pressed("debug_camUp"):
		position.y -= speed
	if Input.is_action_pressed("debug_camDown"):
		position.y += speed
	position.x = clamp(position.x, limits[0],limits[2])
	position.y = clamp(position.y, limits[1],limits[3])
	
