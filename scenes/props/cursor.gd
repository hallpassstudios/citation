extends Node2D

# Load the custom images for the mouse cursor.
var arrow = load("res://sprites/ui/arrow_cursor.png")
var crosshair = load("res://sprites/ui/crosshair_cursor.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_custom_mouse_cursor(crosshair)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
