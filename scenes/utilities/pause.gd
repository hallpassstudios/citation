extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	pass
		
		# show the menu

func toggle_pause_game():
	get_tree().paused = !get_tree().paused
