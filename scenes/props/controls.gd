extends Control

var paused
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if globals.screen_orientation == "portrait":
		paused = true
		if paused:
			get_tree().paused = true
	else:
		get_tree().paused = false
