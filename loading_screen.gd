extends Control

@export var text: String
@export var progress: int
@export var done: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if text:
		$BG/Label.text = text
	else:
		$BG/Label.text = "Loading..."
	$BG/ProgressBar.value = float(progress)
