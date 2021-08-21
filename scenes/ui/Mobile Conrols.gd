extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var jump_button = $jump_button
onready var right_button = $right_button

# Called when the node enters the scene tree for the first time.
func _ready():
	globals.right_button = right_button
	globals.jump_button = jump_button
