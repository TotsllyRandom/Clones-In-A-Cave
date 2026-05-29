extends Camera2D

const speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


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
	
	
