extends Node

@export var LOADING_SCREEN_SCENE: PackedScene
var loading_screen_active = false
var progress := 0
var loading_screen

signal game_start

func make_loading_screen(text: String):
	var screen = LOADING_SCREEN_SCENE.instantiate()
	$Camera2D.enabled = false
	screen.progress = 0
	screen.text = text
	screen.name = "loading_screen"
	add_child(screen)
	loading_screen_active = true
	loading_screen = $loading_screen



func _ready() -> void:
	make_loading_screen("Making Cave...")
	game_start.emit()

func _process(_delta: float):
	if loading_screen_active:
		loading_screen.progress = progress
		if progress >= loading_screen.max_value:
			loading_screen.queue_free()
			$Camera2D.enabled = true
			loading_screen_active = false
