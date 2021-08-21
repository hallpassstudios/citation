extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ui_cancel"): #esc by default
		print("pausing game")
		get_tree().paused = !get_tree().paused # toggles pause status

func toggle_pause_game():
	get_tree().paused = !get_tree().paused
