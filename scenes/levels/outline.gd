extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func outline(value):
	if value:
		# we should access our parent sprite and highlight the object
		get_child(0).material.set_shader_param("width", 1)
	else: 
		get_child(0).material.set_shader_param("width", 0)

