extends Node

signal game_start

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_start.emit()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
