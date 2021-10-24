extends Node2D

onready var container = $desk/papers
func _ready():
	print("classroom entered")
	
func open_desk(value):
	globals.caught_joe = true
	if value[0] == "true":
		print("opening the desk")
		container.visible = true
		globals.caught_joe = true
	else: 
		container.visible = false
