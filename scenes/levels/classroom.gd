extends Node2D

onready var container = $desk/container
func _ready():
	print("classroom entered")
	
func open_desk(value):
	if value[0] == "true":
		print("opening the desk")
		container.visible = true
		globals.caught_joe = true
	else: 
		container.visible = false
