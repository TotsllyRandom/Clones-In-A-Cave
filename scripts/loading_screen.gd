extends CanvasLayer

@export var text: String
@export var progress: int = 0
@export var done: bool
@export var max_value := 100


func _process(_delta: float) -> void:
	if text:
		$BG/Label.text = text
	else:
		$BG/Label.text = "Loading..."
	$BG/ProgressBar.value = float(progress)
	
	
